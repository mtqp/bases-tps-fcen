package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Collection;

import ConsoleOut.ConsoleOut;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.PageReplacementStrategyException;

public class TouchCountReplacementStrategy implements PageReplacementStrategy{

	private int countIntervalSeconds = 3;
	private int agingHotCriteria = 2;

	public TouchCountReplacementStrategy(){}
	
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
				break;
			}
		}

		/*
		 * Si todos tienen touchCount > agingHotCriteria esto da nulo, uno tiene que sacar
		 */
		if(victim==null)
		{
			/*
			 * Busco el de menor touchCount y fecha de referencia
			 */
			TouchCountBufferFrame lruWithMinTouchCount = null;
			
			for (BufferFrame bufferFrame : bufferFrames) {
				TouchCountBufferFrame touchCountBufferFrame = (TouchCountBufferFrame) bufferFrame;

				boolean frameCanBeReplaced = touchCountBufferFrame.canBeReplaced();
				if(lruWithMinTouchCount == null && frameCanBeReplaced)
					lruWithMinTouchCount = touchCountBufferFrame;
				else
				{
					boolean hasLessTouchCount = touchCountBufferFrame.getTouchCount() < lruWithMinTouchCount.getTouchCount();
					boolean hasEqualTouchCount = touchCountBufferFrame.getTouchCount() == lruWithMinTouchCount.getTouchCount();
					boolean hasLessReferenceDate = touchCountBufferFrame.getReferenceDate().before(lruWithMinTouchCount.getReferenceDate());
					if (frameCanBeReplaced && (hasLessTouchCount ||(hasEqualTouchCount && hasLessReferenceDate))) {
						lruWithMinTouchCount = touchCountBufferFrame;
					}
				}
			}
			
			victim = lruWithMinTouchCount;
		}
		
		if(victim == null)
			throw new PageReplacementStrategyException("No page can be removed from pool");
		
		ConsoleOut.printReferenceFramesAndVictim(victim, bufferFrames);
		
		return victim;
	}


	
	public BufferFrame createNewFrame(Page page) {
		return new TouchCountBufferFrame(page, countIntervalSeconds);
	}
}
