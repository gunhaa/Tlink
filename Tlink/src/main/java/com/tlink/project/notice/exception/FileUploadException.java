package com.tlink.project.notice.exception;

public class FileUploadException extends Exception {

	public FileUploadException() {
		super("파일 업로드 중 예외 발생");
	}

	public FileUploadException(String message) {
		super(message);		
	}

}
