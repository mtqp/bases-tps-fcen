package ubadb.core.components.bufferManager.bufferPool.pools.TouchCount;

import java.util.ArrayList;
import java.util.List;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount.TouchCountBufferFrame;
import ubadb.core.exceptions.BufferFrameException;
import ubadb.core.exceptions.BufferPoolException;

/**
 * A single buffer pool shared by all tables
 * 
 */
public class TouchCountBufferPool implements BufferPool {

	private List<BufferFrame> framesPool;
	private PageReplacementStrategy pageReplacementStrategy;
	private final int hotPercentage; // Es el porcentaje de frames en la lista
										// de hot que debe mantenerse
										// invariante.
	private final int agingHotCriteria; // Umbral bajo el cual acepto que el
										// frame se pase a la lista de hot.
	private final int agingCoolCount; // touchCount que se le colca a un Frame
										// que pasa a la lista cold.
	private final int maxBufferPoolSize;

	/* Apunta al elemento HOT mas cercano a la cold region */
	private int midPoint;

	public TouchCountBufferPool(int maxBufferPoolSize, int percentHotDefault,
			int agingHotCriteria, int agingCoolCount,
			PageReplacementStrategy pageReplacementStrategy) {
		this.maxBufferPoolSize = maxBufferPoolSize;
		this.hotPercentage = percentHotDefault;
		this.agingHotCriteria = agingHotCriteria;
		this.agingCoolCount = agingCoolCount;
		CheckParametersBoundaries();
		this.pageReplacementStrategy = pageReplacementStrategy;
		this.framesPool = new ArrayList<BufferFrame>();
	}

	private void CheckParametersBoundaries() {
		// TODO Auto-generated method stub
		// checkear que sean validos los parametros del constructor lalalal
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

	/**
	 * Aplica el algoritmo de reorganizacion de los frames, pasando de cold a
	 * hot region los que superan el umbral
	 */
	public void reorganizeFrames() {
		List<Integer> newHotIndexes = new ArrayList<>();

		for (int i = 0; i < this.framesPool.size(); i++) {
			boolean isInColdRegion = i < this.midPoint;

			if (!isInColdRegion)
				break;

			TouchCountBufferFrame touchCountBufferFrame = (TouchCountBufferFrame) this.framesPool
					.get(i);

			if (touchCountBufferFrame.getPinCount() >= this.agingHotCriteria)
				newHotIndexes.add(i);
		}

		for (int newHotIndexFrame : newHotIndexes)
			MoveFrameToHot(newHotIndexFrame);
	}

	private void MoveFrameToHot(int indexFrame) {
		TouchCountBufferFrame frameToCold = (TouchCountBufferFrame) this.framesPool
				.get(this.midPoint);
		TouchCountBufferFrame frameToHot = (TouchCountBufferFrame) this.framesPool
				.get(indexFrame);

		frameToCold.setTouchCount(this.agingCoolCount);
		frameToHot.setTouchCount(0);

		this.framesPool.remove(indexFrame);
		this.framesPool.add(frameToHot);
	}

	public BufferFrame addNewPage(Page page) throws BufferPoolException {
		if (!hasSpace(page.getPageId()))
			throw new BufferPoolException("No space in pool for new page");
		else if (isPageInPool(page.getPageId()))
			throw new BufferPoolException("Page already exists in the pool");
		else {
			BufferFrame bufferFrame = pageReplacementStrategy
					.createNewFrame(page);
			this.framesPool.add(midPoint, bufferFrame);
			try {

				this.reloadMidPointerOnAddingFrame();
			} catch (BufferFrameException e) {
				throw new BufferPoolException(e.getMessage());
			}

			return bufferFrame;
		}
	}

	private void reloadMidPointerOnAddingFrame() throws BufferFrameException {
		int hotElements = CalculateElementsCountInHotRegion();
		int diference = Math.abs(this.midPoint
				- (this.framesPool.size() - hotElements));
		if (diference > 1)
			throw new BufferFrameException(
					"No se permite mover mas de un elemento.");

		boolean needAdd = diference == 1;
		if (needAdd)
			MoveColdToHot();

		this.midPoint = this.framesPool.size() - hotElements;
	}

	// chequear contra la respuesta de Diego en el email que enviamos
	private void MoveColdToHot() throws BufferFrameException {
		int maxTouchCount = 0;
		TouchCountBufferFrame maxFrame = null;
		for (int index = 0; index < this.midPoint; index++) {
			TouchCountBufferFrame frame = (TouchCountBufferFrame) this.framesPool.get(index);
			if (frame.getTouchCount() > maxTouchCount) {
				maxTouchCount = frame.getTouchCount();
				maxFrame = frame;
			}
		}
		
		if (maxFrame == null)
			throw new BufferFrameException("No se encontro frame para mover.");
			
		MoveColdBufferToHot(maxFrame);
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
			try {
					int frameToRemoveIndex = FindFrameIndex(frame);
					boolean isInColdRegion = frameToRemoveIndex < this.midPoint;
					int oldElementsCount = CalculateElementsCountInHotRegion();
					this.framesPool.remove(frameToRemoveIndex);
					if (!isInColdRegion)
						this.reloadMidPointerOnAddingFrame();
					else
					{
						int newElementsCount = CalculateElementsCountInHotRegion();
						// Esto vale por la precondicion de que a lo sumo un elemento pasa a la region fria
						if (oldElementsCount != newElementsCount)
						{
							TouchCountBufferFrame frameToCold = (TouchCountBufferFrame)this.framesPool.get(this.midPoint);
							frameToCold.setTouchCount(this.agingCoolCount);
							this.midPoint ++;
						}
					}
			} catch (Exception e) {
				throw new BufferPoolException(e.getMessage());
			}
		} else
			throw new BufferPoolException("Cannot remove an unexisting page");
	}

	private int CalculateElementsCountInHotRegion() {
		double hotPercentage = this.hotPercentage / 100;
		double value = (double) this.framesPool.size() * hotPercentage;
		return (int) Math.floor(value);
	}

	private int FindFrameIndex(BufferFrame frame) {
		int frameToRemoveIndex = 0;
		for(int index = 0; index < this.framesPool.size(); index++)
		{
			if (this.framesPool.get(index).getPage().equals(frame.getPage()))
			{
				frameToRemoveIndex = index;
				break;
			}
		}
		return frameToRemoveIndex;
	}

	public BufferFrame findVictim(PageId pageIdToBeAdded)
			throws BufferPoolException {
		try {
			BufferFrame victim = pageReplacementStrategy
					.findVictim(this.framesPool);

			List<TouchCountBufferFrame> buffersToMoveToHot = findBuffersToMove(victim);

			for (TouchCountBufferFrame frameToHot : buffersToMoveToHot) {

				TouchCountBufferFrame frameToCold = ((TouchCountBufferFrame) this.framesPool
						.get(this.midPoint));
				frameToCold.setTouchCount(this.agingCoolCount);

				MoveColdBufferToHot(frameToHot);
			}

			return victim;

		} catch (Exception e) {
			throw new BufferPoolException(
					"Cannot find a victim page for removal", e);
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
}
