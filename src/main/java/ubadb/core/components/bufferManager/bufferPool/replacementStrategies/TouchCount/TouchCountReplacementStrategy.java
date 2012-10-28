package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Collection;
import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class TouchCountReplacementStrategy implements PageReplacementStrategy {

	private static int TOUCH_COUNT_INTERVAL_SECONDS = 3;

	public BufferFrame findVictim(Collection<BufferFrame> bufferFrames)
			throws PageReplacementStrategyException {
		TouchCountBufferFrame victim = null;
		int minTouchCount = Integer.MAX_VALUE;

		for (BufferFrame bufferFrame : bufferFrames) {
			TouchCountBufferFrame touchCountBufferFrame = (TouchCountBufferFrame) bufferFrame;
			if (touchCountBufferFrame.canBeReplaced()
					&& minTouchCount > touchCountBufferFrame.getTouchCount()) {
				victim = touchCountBufferFrame;
				minTouchCount = touchCountBufferFrame.getTouchCount();
			}
		}

		if (victim == null)
			throw new PageReplacementStrategyException(
					"No page can be removed from pool");
		else
			return victim;
	}

	public BufferFrame createNewFrame(Page page) {
		return new TouchCountBufferFrame(page, TOUCH_COUNT_INTERVAL_SECONDS);
	}
}
