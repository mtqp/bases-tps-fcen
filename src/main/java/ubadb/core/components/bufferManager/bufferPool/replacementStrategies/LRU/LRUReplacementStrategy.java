package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.LRU;

import java.util.Collection;
import java.util.Date;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class LRUReplacementStrategy implements PageReplacementStrategy {
	public BufferFrame findVictim(Collection<BufferFrame> bufferFrames)
			throws PageReplacementStrategyException {
		ReferenceBufferFrame victim = null;
		Date oldestReplaceablePageDate = null;

		for (BufferFrame bufferFrame : bufferFrames) {
			ReferenceBufferFrame lruBufferFrame = (ReferenceBufferFrame) bufferFrame;
			
			// Si encuentra una pagina que nunca fue referenciada, la devuelve y sale del for sin seguir buscando
			if(lruBufferFrame.canBeReplaced() && lruBufferFrame.getReferenceDate() == null ) {
				victim = lruBufferFrame;
				break;
			}
			
			if (lruBufferFrame.canBeReplaced()
					&& (oldestReplaceablePageDate == null || lruBufferFrame
							.getReferenceDate().before(
									oldestReplaceablePageDate))) {
				victim = lruBufferFrame;
				oldestReplaceablePageDate = lruBufferFrame.getReferenceDate();
			}
			
		}

		if (victim == null)
			throw new PageReplacementStrategyException(
					"No page can be removed from pool");
		else
			return victim;
	}

	public BufferFrame createNewFrame(Page page) {
		return new ReferenceBufferFrame(page);
	}
}
