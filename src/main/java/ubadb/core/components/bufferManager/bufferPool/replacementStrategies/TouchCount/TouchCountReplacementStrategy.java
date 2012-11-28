package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Collection;
import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.LRU.LRUReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class TouchCountReplacementStrategy extends LRUReplacementStrategy implements PageReplacementStrategy{

	private int countIntervalSeconds = 3;

	public TouchCountReplacementStrategy(int countIntervalSeconds){
		this.countIntervalSeconds = countIntervalSeconds;
	}
	
	/*
	 * Devuelve la pagina con touch_count minimo, en caso de haber mas de uno
	 * devuelve el de date de referencia mas vieja. --> Es la misma implementacion que una LRU
	 */
	public BufferFrame findVictim(Collection<BufferFrame> bufferFrames)	throws PageReplacementStrategyException {
		return super.findVictim(bufferFrames);
	}
	
	@Deprecated
	public BufferFrame findVictimOLD(Collection<BufferFrame> bufferFrames)	throws PageReplacementStrategyException {
		TouchCountBufferFrame victim = null;
		int minTouchCount = 0;

		for (BufferFrame bufferFrame : bufferFrames) {
			TouchCountBufferFrame touchCountBufferFrame = (TouchCountBufferFrame) bufferFrame;
			if (touchCountBufferFrame.canBeReplaced() && touchCountBufferFrame.getTouchCount() < minTouchCount) {
				victim = touchCountBufferFrame;
				minTouchCount = touchCountBufferFrame.getTouchCount();
			}
		}

		if (victim == null)
			throw new PageReplacementStrategyException("No page can be removed from pool");
		else
			return victim;
	}

	public BufferFrame createNewFrame(Page page) {
		return new TouchCountBufferFrame(page, countIntervalSeconds);
	}
}
