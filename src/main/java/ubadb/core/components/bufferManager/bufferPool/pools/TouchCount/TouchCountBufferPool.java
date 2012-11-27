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
	private final int hotPercentage;
	private final int agingHotCriteria;
	private final int agingCoolCount;
	private final int maxBufferPoolSize;

	/*Apunta al elemento HOT mas cercano a la cold region*/
	private int midPoint;
	
	public TouchCountBufferPool(int maxBufferPoolSize, int percentHotDefault, int agingHotCriteria, int agingCoolCount, 
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
		//TODO: determinar si es el correcto lugar para reorganizar los items!!!! LALALA
		reorganizeFrames();
		
		return countPagesInPool() < maxBufferPoolSize;
	}
	
	/**
	 * Aplica el algoritmo de reorganizacion de los frames, 
	 * pasando de cold a hot region los que superan el umbral
	 */
	public void reorganizeFrames(){
		List<Integer> newHotIndexes = new ArrayList<>();
		
		for (int i=0;i<this.framesPool.size();i++) {
			boolean isInColdRegion = i < this.midPoint;

			if(!isInColdRegion)
				break;
			
			TouchCountBufferFrame touchCountBufferFrame = (TouchCountBufferFrame)this.framesPool.get(i);
			
			if(touchCountBufferFrame.getPinCount() >= this.agingHotCriteria)
				newHotIndexes.add(i);
		}
		
		for(int newHotIndexFrame : newHotIndexes)
			MoveFrameToHot(newHotIndexFrame);
	}

	private void MoveFrameToHot(int indexFrame) {
		TouchCountBufferFrame frameToCold = (TouchCountBufferFrame) this.framesPool.get(this.midPoint);
		TouchCountBufferFrame frameToHot = (TouchCountBufferFrame) this.framesPool.get(indexFrame);
		
		try {
			frameToCold.setPin(this.agingCoolCount);
			frameToHot.setPin(0);
		} catch (BufferFrameException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		this.framesPool.remove(indexFrame);
		this.framesPool.add(frameToHot);
	}

	public BufferFrame addNewPage(Page page) throws BufferPoolException {
		if (!(countPagesInPool() < maxBufferPoolSize))
			throw new BufferPoolException("No space in pool for new page");
		else if (isPageInPool(page.getPageId()))
			throw new BufferPoolException("Page already exists in the pool");
		else {
			BufferFrame bufferFrame = pageReplacementStrategy.createNewFrame(page);
			this.framesPool.add(midPoint, bufferFrame);
			try {
				this.reloadMidPointer();
			} catch (BufferFrameException e) {
				throw new BufferPoolException(e.getMessage());
			}
			
			return bufferFrame;
		}
	}

	private void reloadMidPointer() throws BufferFrameException {
		double hotPercentage = this.hotPercentage / 100;
		double value = (double) this.framesPool.size() * hotPercentage;
		int newMidPoint = (int) Math.ceil(value);
		
		if(this.midPoint > newMidPoint){
			/*
			 * Uno que estaba en la cold paso a la hot region
			 */
			
			TouchCountBufferFrame touchCountBufferFrame = ((TouchCountBufferFrame)this.framesPool.get(newMidPoint));
			touchCountBufferFrame.setPin(0);
		}
		else {
			/*
			 * Uno que estaba en la hot region paso a la cold
			 */
			
			TouchCountBufferFrame touchCountBufferFrame = ((TouchCountBufferFrame)this.framesPool.get(this.midPoint));
			touchCountBufferFrame.setPin(this.agingCoolCount);
		}
		
		this.midPoint = newMidPoint;
	}


	public void removePage(PageId pageId) throws BufferPoolException {
		if (isPageInPool(pageId)) {
			BufferFrame frame = findBufferInPool(pageId);
			this.framesPool.remove(frame);
			try {
				this.reloadMidPointer();
			} catch (BufferFrameException e) {
				throw new BufferPoolException(e.getMessage());
			}
		} else
			throw new BufferPoolException("Cannot remove an unexisting page");
	}

	public BufferFrame findVictim(PageId pageIdToBeAdded) throws BufferPoolException {
		try {
			return pageReplacementStrategy.findVictim(this.framesPool);
		} catch (Exception e) {
			throw new BufferPoolException("Cannot find a victim page for removal", e);
		}
	}

	public int countPagesInPool() {
		return this.framesPool.size();
	}
}
