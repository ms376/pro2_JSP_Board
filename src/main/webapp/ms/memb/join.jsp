<%@ page import = "membership.MemberDAO" %>
<%@ page import = "membership.MemberDTO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" 	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
<style>
	.input{
	align-items: center;
	}
</style>
</head>

<body>
    <div class="container">
        <div class="col-lg-4" style="margin-top: 100px;">
            <div class ="form-floating" style="padding-top:20px;">
                    <h3 style="text-align:center;">회원가입</h3>
	<img class="mb-4" src="daa.jpg" alt=""  style="width:450px; height:350px; padding-top:20px; margin-left: 250px; margin-bottom: 20px;">
                <form method = "post" action="../../membership/RegisterServlet.do">
                    <div class ="form-group" align="center">
                        <input type ="text" class="form-control" placeholder="아이디를 입력해주세요" name ="id" style="width: 200px;" maxlength='20'>
                    </div>
                    <div class ="form-group" align="center">
                        <input type ="password" class="form-control" placeholder="비밀번호를 입력해주세요" name ="pass" style="width: 200px;" maxlength='20'>
                    </div>
                    <div class ="form-group"align="center">
                        <input type ="name" class="form-control" placeholder="이름을 입력해주세요" name ="name" style="width: 200px;" maxlength='10'>
                    </div>
                    <div style="width:100px; height:50px; margin-left: 410px;">
                    <input type="submit" class="btn btn-primary form-control" value="회원가입">
                    </div>
                </form>
        </div> </div>
        <div class="col-lg-4"></div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</body>
</html>