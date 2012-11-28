package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.MRU;

import java.util.Collection;
import java.util.Date;

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

		for (BufferFrame bufferFrame : bufferFrames) {
			ReferenceBufferFrame mruBufferFrame = (ReferenceBufferFrame) bufferFrame;
			
			// Si encuentra una pagina que nunca fue referenciada, la devuelve y sale del for sin seguir buscando
			if(mruBufferFrame.canBeReplaced() && mruBufferFrame.getReferenceDate() == null ) {
				victim = mruBufferFrame;
				break;
			}
			
			if (mruBufferFrame.canBeReplaced()
					&& (recentReplaceablePageDate == null || mruBufferFrame
							.getReferenceDate()
							.after(recentReplaceablePageDate))) {
				victim = mruBufferFrame;
				recentReplaceablePageDate = mruBufferFrame.getReferenceDate();
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