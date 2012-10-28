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
			ReferenceBufferFrame mruBufferFrame = (ReferenceBufferFrame) bufferFrame;
			if (mruBufferFrame.canBeReplaced()
					&& (oldestReplaceablePageDate == null || mruBufferFrame
							.getReferenceDate().before(
									oldestReplaceablePageDate))) {
				victim = mruBufferFrame;
				oldestReplaceablePageDate = mruBufferFrame.getReferenceDate();
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