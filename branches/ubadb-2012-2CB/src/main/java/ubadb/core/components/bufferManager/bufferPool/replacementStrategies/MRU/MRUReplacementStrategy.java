package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.MRU;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class MRUReplacementStrategy implements PageReplacementStrategy {
	public BufferFrame findVictim(Collection<BufferFrame> bufferFrames)
			throws PageReplacementStrategyException {
		ReferenceBufferFrame victim = null;
		Date recentReplaceablePageDate = null;
		List<ReferenceBufferFrame> mostRecentlyUsedFrames = new ArrayList<ReferenceBufferFrame>();
		
		int maxPinCount = 0;
		for (BufferFrame bufferFrame : bufferFrames) {
			if(bufferFrame.getPinCount() > maxPinCount){
				maxPinCount = bufferFrame.getPinCount();
			}
		}
		
		for (BufferFrame bufferFrame : bufferFrames) {
			if(bufferFrame.getPinCount() == maxPinCount){
				mostRecentlyUsedFrames.add((ReferenceBufferFrame)bufferFrame);
			}
		}
		
		for (ReferenceBufferFrame mostUsedBufferFrame : mostRecentlyUsedFrames) {
			
			if (recentReplaceablePageDate == null || mostUsedBufferFrame.getReferenceDate().after(recentReplaceablePageDate)) {
				victim = mostUsedBufferFrame;
				recentReplaceablePageDate = mostUsedBufferFrame.getReferenceDate();
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
		//Seria necesario hacer un pin como que se cargo a la cache? asumimos que no porque quizas
		//como en el caso de un filescan, la pagina se subio a caché pero no se uso.
	}
}
