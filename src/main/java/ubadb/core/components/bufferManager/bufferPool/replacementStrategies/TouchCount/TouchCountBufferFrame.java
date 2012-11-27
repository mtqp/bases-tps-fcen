package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Date;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.exceptions.BufferFrameException;

public class TouchCountBufferFrame extends ReferenceBufferFrame {
	private int secondsToIncrementCount;

	public TouchCountBufferFrame(Page page, int secondsToIncrementCount) {
		super(page);
		this.secondsToIncrementCount = secondsToIncrementCount;
	}

	public void pin() {
		if(canIncrementTouchCount()){
			super.pin();
		}
	}

	public void unpin() throws BufferFrameException {
		if(canIncrementTouchCount()){
			super.unpin();
		}
	}
 
	public void setPin(int pinValue) throws BufferFrameException{
		if(pinValue<0)
			throw new BufferFrameException("Cannot set pinValue less than zero");
		
		while(pinValue != this.getPinCount())
		{
			if(pinValue > this.getPinCount())
				this.pin();
			else
				this.unpin();
		}
	}
	
	private boolean canIncrementTouchCount() {
		Date current = new Date();

		long lastTouchedNumber = 0;
		
		int seconds = this.secondsToIncrementCount;
		if(getReferenceDate() != null){
			lastTouchedNumber = getReferenceDate().getTime();
			seconds = (int) ((current.getTime() - lastTouchedNumber) / 1000);
		}
		
		System.out.print("seconds" + seconds + "secondsToIncrementCount" + this.secondsToIncrementCount);
		return (seconds >= this.secondsToIncrementCount);
	}
}
