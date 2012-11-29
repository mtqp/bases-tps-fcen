package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Collection;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class TouchCountReplacementStrategy implements PageReplacementStrategy{

	private int countIntervalSeconds = 3;
	private int agingHotCriteria = 2;

	public TouchCountReplacementStrategy(int countIntervalSeconds, int agingHotCriteria){
		this.countIntervalSeconds = countIntervalSeconds;
		this.agingHotCriteria = agingHotCriteria;
	}
	
	public BufferFrame findVictim(Collection<BufferFrame> bufferFrames)	throws PageReplacementStrategyException {
		TouchCountBufferFrame victim = null;

		for (BufferFrame bufferFrame : bufferFrames) {
			TouchCountBufferFrame touchCountBufferFrame = (TouchCountBufferFrame) bufferFrame;
			if (touchCountBufferFrame.canBeReplaced() && touchCountBufferFrame.getTouchCount() < agingHotCriteria) {
				victim = touchCountBufferFrame;
				return victim;
			}
		}

		throw new PageReplacementStrategyException("No page can be removed from pool");
	}

	public BufferFrame createNewFrame(Page page) {
		return new TouchCountBufferFrame(page, countIntervalSeconds);
	}
}
