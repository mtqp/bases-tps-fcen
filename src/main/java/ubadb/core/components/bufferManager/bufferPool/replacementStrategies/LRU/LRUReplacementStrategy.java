package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.LRU;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class LRUReplacementStrategy implements PageReplacementStrategy {
	
	public BufferFrame findVictim(Collection<BufferFrame> bufferFrames)
			throws PageReplacementStrategyException {
		List<ReferenceBufferFrame> leastRecentlyUsedFrames = new ArrayList<ReferenceBufferFrame>();
		
		int minPinCount = Integer.MAX_VALUE;
		for (BufferFrame bufferFrame : bufferFrames) {
			if(bufferFrame.getPinCount() < minPinCount){
				minPinCount = bufferFrame.getPinCount();
			}
		}
		
		for (BufferFrame bufferFrame : bufferFrames) {
			if(bufferFrame.getPinCount() == minPinCount){
				leastRecentlyUsedFrames.add((ReferenceBufferFrame)bufferFrame);
			}
		}
		
		ReferenceBufferFrame victim = null;
		Date recentReplaceablePageDate = null;

		for (ReferenceBufferFrame leastUsedBufferFrame : leastRecentlyUsedFrames) {
			
			if (recentReplaceablePageDate == null || leastUsedBufferFrame.getReferenceDate().before(recentReplaceablePageDate)) {
				victim = leastUsedBufferFrame;
				recentReplaceablePageDate = leastUsedBufferFrame.getReferenceDate();
			}
			
		}
		
		//Siempre deberia encontrar una victima salvo que la lista de bufferFrames sea vacia
		if (victim == null)
			throw new PageReplacementStrategyException("No page can be removed from pool");
		else
			return victim;
	}

	public BufferFrame createNewFrame(Page page) {
		return new ReferenceBufferFrame(page);
	}
}
