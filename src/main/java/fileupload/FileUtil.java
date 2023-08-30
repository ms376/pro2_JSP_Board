package fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import utils.JSFunction;

public class FileUtil {
	public static MultipartRequest	uploaFile(HttpServletRequest req, String savDirectory, int maxPostSize) {
		try {
			/*
			 	MultipartReqeust(request내장객체, 디렉토리의 물리적 경로, 업로드 제한용량, 인코딩 방식);
			 	위와 같은 형태로 객체를 생성함과 동시에 파일은 업로드된다.
			 	업로드 성공시 객체 참조값 반환
			 	실패시 null반환. 실패했다면 디렉토리경로나 파일용량을 확인해보자
			 */
			return new MultipartRequest(req,savDirectory,maxPostSize,"UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void download(HttpServletRequest req, HttpServletResponse resp, String directory, String sfilenmae, String ofileName) {
		
		String sDirectory = req.getServletContext().getRealPath(directory);
		try {
			File file = new File(sDirectory,sfilenmae);
			InputStream iStream = new FileInputStream(file);
			
			String client = req.getHeader("User-Agent");
			if (client.indexOf("WOW64")== -1){
				ofileName = new String(ofileName.getBytes("UTF-8"),"ISO-8859-1");
			} else {
				ofileName = new String(ofileName.getBytes("KSC5601"),"ISO-8859-1");
			}
			
			//파일 다운로드 응답 헤더 설정
			resp.reset();
			resp.setContentType("application/octet-stream");
			resp.setHeader("content-Disposition", "attachment; filename=\""+ofileName+"\"");
			resp.setHeader("Content-Length",""+ file.length());
			
			//out.clear(); //출력스트림 초기화
			
			//response 내장 객체로부터 새로운 출력 스트림 생성
			OutputStream oStream = resp.getOutputStream();
			
			//출력 스트림에 파일 내용 출력
			byte b[] = new byte[(int)file.length()];
			int readBuffer = 0;
			while ( (readBuffer=iStream.read(b)) > 0 ) {
				oStream.write(b,0,readBuffer);
			}
			
			//입출력 스트림 닫음
			iStream.close();
			oStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			JSFunction.alertBack(resp, "없는 파일입니다");
			System.out.println("파일을 찾을 수 없습니다.");
		}catch (Exception e) {
			e.printStackTrace();
			JSFunction.alertBack(resp, "파일다운로드가 불가능한 게시물입니다");
			System.out.println("파일 다운로드중 예외가 발생하였습니다.");
			
		}
	}
	
	//파일 삭제를 위한 메서드
	public static void deleteFile(HttpServletRequest req, String directory, String filename) {
		//물리적 경로와 파일명을 통해 File 객체를 생성한다.
		String sDirectory = req.getServletContext().getRealPath(directory);
		File file = new File(sDirectory+ File.separator+filename);
		//해당 경로에 파일이 존재하면...
		if (file.exists()) {
			//파일을 삭제한다.
			file.delete();
		}
	}
	
}
