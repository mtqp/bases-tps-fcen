package ubadb.core.components.bufferManager.bufferPool;

import java.util.Date;

import ubadb.core.common.Page;
import ubadb.core.exceptions.BufferFrameException;

public class ReferenceBufferFrame extends BufferFrame {
	private Date referenceDate;

	public ReferenceBufferFrame(Page page) {
		super(page);
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
