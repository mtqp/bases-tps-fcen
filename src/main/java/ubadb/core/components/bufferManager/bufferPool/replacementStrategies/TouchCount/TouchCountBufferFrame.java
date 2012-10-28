package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import java.util.Date;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.exceptions.BufferFrameException;

public class TouchCountBufferFrame extends BufferFrame {
	private Date lastTouchedDate;
	private int touchCount = 0;
	private int secondsToIncrementCount;

	public TouchCountBufferFrame(Page page, int secondsToIncrementCount) {
		super(page);
		this.secondsToIncrementCount = secondsToIncrementCount;
	}

	// llamo al correcto y me fijo si tengo que actualizar el touchCount
	public void pin() {
		super.pin();
		incrementTouchCountIfNeeded();
	}

	public int getTouchCount() {
		return this.touchCount;
	}

	// llamo al correcto y me fijo si tengo que actualizar el touchCount
	public void unpin() throws BufferFrameException {
		super.unpin();
		incrementTouchCountIfNeeded();
	}

	private void incrementTouchCountIfNeeded() {
		Date current = new Date();
		int seconds = (int) ((current.getTime() - lastTouchedDate.getTime()) / 1000);
		if (seconds >= this.secondsToIncrementCount) {
			touchCount++;
			lastTouchedDate = current;
		}
	}
}
