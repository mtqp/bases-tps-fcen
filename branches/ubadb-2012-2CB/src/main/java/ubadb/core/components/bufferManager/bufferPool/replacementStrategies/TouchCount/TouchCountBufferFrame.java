package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Date;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.exceptions.BufferFrameException;

public class TouchCountBufferFrame extends ReferenceBufferFrame {
	private int secondsToIncrementCount;
	private int touchCount;
	
	public TouchCountBufferFrame(Page page, int secondsToIncrementCount) {
		super(page);
		this.secondsToIncrementCount = secondsToIncrementCount;
		touchCount = 0;
	}

	public void pin() {
		if(canIncrementTouchCount()){
			this.touchCount++;
		}
		
		super.pin();
	}

	public int getTouchCount(){
		return touchCount;
	}
	
	public void setTouchCount(int touchCountvalue){
		this.touchCount = touchCountvalue;
	}
	
	public void unpin() throws BufferFrameException {
		if(canIncrementTouchCount()){
			this.touchCount++;
		}
		
		super.unpin();
	}
	
	private boolean canIncrementTouchCount() {
		Date current = new Date();

		long lastTouchedNumber = 0;
		
		int seconds = this.secondsToIncrementCount;
		if(getReferenceDate() != null){
			lastTouchedNumber = getReferenceDate().getTime();
			seconds = (int) ((current.getTime() - lastTouchedNumber) / 1000);
		}
		
		//System.out.println("seconds: " + seconds + " | secondsToIncrementCount: " + this.secondsToIncrementCount);
		return (seconds >= this.secondsToIncrementCount);
	}
	
	@Override
	public String toString() {
		return "Id: " + getPage().getPageId().getNumber(); 
	}
}
