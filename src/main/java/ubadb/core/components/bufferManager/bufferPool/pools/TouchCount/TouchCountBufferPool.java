package ubadb.core.components.bufferManager.bufferPool.pools.TouchCount;

import java.util.ArrayList;
import java.util.List;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount.TouchCountBufferFrame;
import ubadb.core.exceptions.BufferPoolException;

/**
 * A single buffer pool shared by all tables
 * 
 */
public class TouchCountBufferPool implements BufferPool {

	private List<BufferFrame> framesPool;
	private PageReplacementStrategy pageReplacementStrategy;
	private final double hotPercentage; // Es el porcentaje de frames en la lista
										// de hot que debe mantenerse
										// invariante.
	private final int agingHotCriteria; // Umbral bajo el cual acepto que el
										// frame se pase a la lista de hot.
	private final int agingCoolCount; // touchCount que se le colca a un Frame
										// que pasa a la lista cold.
	private final int maxBufferPoolSize;

	/* Apunta al elemento HOT mas cercano a la cold region */
	private int midPoint;
	
	public TouchCountBufferPool(int maxBufferPoolSize, double percentHotDefault, PageReplacementStrategy pageReplacementStrategy) {
		this(maxBufferPoolSize, percentHotDefault, 3, 1 ,pageReplacementStrategy);
	}
	
	public TouchCountBufferPool(int maxBufferPoolSize, double percentHotDefault,
			int agingHotCriteria, int agingCoolCount,
			PageReplacementStrategy pageReplacementStrategy) {
		this.maxBufferPoolSize = maxBufferPoolSize;
		this.hotPercentage = percentHotDefault;
		this.agingHotCriteria = agingHotCriteria;
		this.agingCoolCount = agingCoolCount;
		this.pageReplacementStrategy = pageReplacementStrategy;
		this.framesPool = new ArrayList<BufferFrame>();
		this.midPoint = 0;
	}

	public boolean isPageInPool(PageId pageId) {
		for (BufferFrame current : this.framesPool) {
			if (current.getPage().getPageId().equals(pageId))
				return true;
		}

		return false;
	}

	private BufferFrame findBufferInPool(PageId pageId) {
		for (BufferFrame current : this.framesPool) {
			if (current.getPage().getPageId().equals(pageId))
				return current;
		}

		return null;
	}

	public BufferFrame getBufferFrame(PageId pageId) throws BufferPoolException {
		if (isPageInPool(pageId))
			return findBufferInPool(pageId);
		else
			throw new BufferPoolException("The requested page is not in the pool");
	}

	/**
	 * Search for an empty space and at the same time reorganize the buffer
	 */
	public boolean hasSpace(PageId pageToAddId) {
		return countPagesInPool() < maxBufferPoolSize;
	}


	public BufferFrame addNewPage(Page page) throws BufferPoolException {
		if (!hasSpace(page.getPageId()))
			throw new BufferPoolException("No space in pool for new page");
		else if (isPageInPool(page.getPageId()))
			throw new BufferPoolException("Page already exists in the pool");
		else {
			BufferFrame bufferFrame = pageReplacementStrategy.createNewFrame(page);
			if(midPoint == this.framesPool.size()){
				this.framesPool.add(bufferFrame);
			}else{
				this.framesPool.add(midPoint, bufferFrame);
			}
			this.reloadMidPointerAfterFramesPoolChanged();

			return bufferFrame;
		}
	}

	private void reloadMidPointerAfterFramesPoolChanged()  {
		int hotElements = CalculateElementsCountInHotRegion();
		this.midPoint = this.framesPool.size() - hotElements;
	}

	private void MoveColdBufferToHot(TouchCountBufferFrame maxFrame) {
		maxFrame.setTouchCount(0);
		this.framesPool.remove(maxFrame);
		this.framesPool.add(maxFrame);
	}

	public void removePage(PageId pageId) throws BufferPoolException {
		if (isPageInPool(pageId)) {
			BufferFrame frame = findBufferInPool(pageId);
			this.framesPool.remove(frame);
			this.reloadMidPointerAfterFramesPoolChanged();
			
		} else
			throw new BufferPoolException("Cannot remove an unexisting page");
	}

	private int CalculateElementsCountInHotRegion() {
		double hotPercentage = this.hotPercentage / 100.0;
		double value = (double) this.framesPool.size() * hotPercentage;
		return (int) Math.floor(value);
	}

	/**
	 * Precondición: el pageId no está en el bufferPool y el bufferPool no tiene espacio.
	 */
	public BufferFrame findVictim(PageId pageIdToBeAdded) throws BufferPoolException {
		
		if(hasSpace(pageIdToBeAdded)){
			throw new BufferPoolException("The buffer still has space");
		}
		
		if(isPageInPool(pageIdToBeAdded)){
			throw new BufferPoolException("The page is already in the buffer");
		}
		
		try {
			BufferFrame victim = pageReplacementStrategy.findVictim(this.framesPool);

			List<TouchCountBufferFrame> buffersToMoveToHot = findBuffersToMove(victim);

			for (TouchCountBufferFrame frameToHot : buffersToMoveToHot) {

				TouchCountBufferFrame frameToCold = ((TouchCountBufferFrame) this.framesPool.get(this.midPoint));
				frameToCold.setTouchCount(this.agingCoolCount);

				MoveColdBufferToHot(frameToHot);
			}

			return victim;

		} catch (Exception e) {
			throw new BufferPoolException("Cannot find a victim page for removal", e);
		}
	}

	private List<TouchCountBufferFrame> findBuffersToMove(BufferFrame victim) {

		List<TouchCountBufferFrame> buffersToMoveToHot = new ArrayList<TouchCountBufferFrame>();
		
		for (BufferFrame bufferFrame : this.framesPool) {

			if (bufferFrame.getPage().equals(victim.getPage())) {
				break;
			}

			TouchCountBufferFrame touchCountFrame = (TouchCountBufferFrame) bufferFrame;

			if (touchCountFrame.getTouchCount() >= agingHotCriteria) {
				buffersToMoveToHot.add(touchCountFrame);
			}
		}
		return buffersToMoveToHot;
	}

	public int countPagesInPool() {
		return this.framesPool.size();
	}
	
	public int getMidPointer(){
		return midPoint;
	}
}
