package com.tlink.project.common.utility;

import java.text.SimpleDateFormat;

public class Util {

	// Cross Site Scriptiog(XSS) 방지 처리
	// - 웹 애플리케이션에서 발생하는 취약점
	// - 권한이 없는 사용자가 사이트에 스크립트를 작성하는 

	public static String newLineHandling(String content) {
		return content.replaceAll("(\\r\\n|\\n\\r|\\n|\\r)","<br>");
	}

	public static String XSShandling(String content) {

		// <h1>
		content = content.replaceAll("&", "&amp;"); // </h1>;
		content = content.replaceAll("<", "&lt;"); // &lt;h1>
		content = content.replaceAll(">", "&gt;"); // &lt;h1&gt;
		content = content.replaceAll("\"", "&quot;"); // &lt;h1&gt;

		return content;

	}


	// 파일명 변경 메소드
	public static String fileRename(String originFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성

		String str = "_" + String.format("%05d", ranNum);

		String ext = originFileName.substring(originFileName.lastIndexOf("."));

		return date + str + ext;
	}



}
