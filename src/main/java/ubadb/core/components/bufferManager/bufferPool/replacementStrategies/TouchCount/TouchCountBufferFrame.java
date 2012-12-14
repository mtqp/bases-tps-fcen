package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Date;

import ConsoleOut.ConsoleOut;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.exceptions.BufferFrameException;

public class TouchCountBufferFrame extends ReferenceBufferFrame {
	private int secondsToIncrementCount;
	private int touchCount;
	private Date touchCountReferenceDate;
	
	public TouchCountBufferFrame(Page page, int secondsToIncrementCount) {
		super(page);
		this.secondsToIncrementCount = secondsToIncrementCount;
		touchCount = 0;
	}

	public void pin() {
		if(canIncrementTouchCount()){
			this.touchCount++;
			touchCountReferenceDate = new Date();
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
			touchCountReferenceDate = new Date();
		}
		
		super.unpin();
	}
	
	private boolean canIncrementTouchCount() {
		Date current = new Date();

		long lastTouchedNumber = 0;
		
		int seconds = this.secondsToIncrementCount;
		if(touchCountReferenceDate != null){
			lastTouchedNumber = touchCountReferenceDate.getTime();
			seconds = (int) ((current.getTime() - lastTouchedNumber) / 1000);
		}
		
		ConsoleOut.touchCountBufferFrame(this);
		ConsoleOut.seconds(seconds, this.secondsToIncrementCount);

		return (seconds >= this.secondsToIncrementCount);
	}
	
	@Override
	public String toString() {
		return "Id: " + getPage().getPageId().getNumber(); 
	}
}
