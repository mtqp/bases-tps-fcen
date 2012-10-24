package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.MRU;

import java.util.Date;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.exceptions.BufferFrameException;

public class MRUBufferFrame extends BufferFrame {
	private Date referenceDate;

	public MRUBufferFrame(Page page) {
		super(page);
		referenceDate = new Date();
	}

	public Date getReferenceDate() {
		return referenceDate;
	}

	// llamo al correcto y actualizo la fecha
	public void pin() {
		super.pin();
		referenceDate = new Date();
	}

	// llamo al correcto y actualizo la fecha
	public void unpin() throws BufferFrameException {
		super.unpin();
		referenceDate = new Date();
	}
}
