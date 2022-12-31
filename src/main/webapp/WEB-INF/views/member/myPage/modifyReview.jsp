<%@ page import="com.google.gson.Gson" %>
<%@ page import="kh.deli.global.entity.ReviewDTO" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="java.lang.String" %>
<%--
  Created by IntelliJ IDEA.
  User: 이나경
  Date: 2022-12-14
  Time: 오후 12:00
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>딜리 - 리뷰수정</title>
    <%@ include file="/WEB-INF/views/global/m-commonLib.jsp" %>
    <link rel="stylesheet" href="/resources/css/member/myPage/modifyReview.css">
</head>
<body>
<%@ include file="/WEB-INF/views/customHeader/m_header.jsp" %>
<%@ include file="/WEB-INF/views/customHeader/m_back.jsp" %>
<%@ include file="/WEB-INF/views/customHeader/m_home.jsp" %>
<main id="modify_review">
    <hr class="mt65">
    <div class="container">
        <form action="/myPage/review/modify" id="reviewPost" method="post"
              enctype="multipart/form-data">
            <%--            <div>--%>
            <%--                <div id="back">--%>
            <%--                    <button id="backBtn" type="button">Back</button>--%>
            <%--                </div>--%>
            <%--                <div> 리뷰수정</div>--%>
            <%--                <div>${store_dto.store_name}</div>--%>
            <%--                <div>--%>
            <%--                    <fieldset>--%>
            <%--                        <c:if test="${review_dto.rev_star eq 1}">--%>
            <%--                            <input type="radio" name="rev_star" value="1" id="rate1" checked><label--%>
            <%--                                for="rate1">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="2" id="rate2"><label--%>
            <%--                                for="rate2">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="3" id="rate3"><label--%>
            <%--                                for="rate3">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="4" id="rate4"><label--%>
            <%--                                for="rate4">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="5" id="rate5"><label--%>
            <%--                                for="rate5">★</label>--%>
            <%--                        </c:if>--%>

            <%--                        <c:if test="${review_dto.rev_star eq 2}">--%>
            <%--                            <input type="radio" name="rev_star" value="1" id="rate1"><label--%>
            <%--                                for="rate1">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="2" id="rate2" checked><label--%>
            <%--                                for="rate2">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="3" id="rate3"><label--%>
            <%--                                for="rate3">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="4" id="rate4"><label--%>
            <%--                                for="rate4">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="5" id="rate5"><label--%>
            <%--                                for="rate5">★</label>--%>
            <%--                        </c:if>--%>

            <%--                        <c:if test="${review_dto.rev_star eq 3}">--%>
            <%--                            <input type="radio" name="rev_star" value="1" id="rate1"><label--%>
            <%--                                for="rate1">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="2" id="rate2"><label--%>
            <%--                                for="rate2">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="3" id="rate3" checked><label--%>
            <%--                                for="rate3">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="4" id="rate4"><label--%>
            <%--                                for="rate4">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="5" id="rate5"><label--%>
            <%--                                for="rate5">★</label>--%>
            <%--                        </c:if>--%>

            <%--                        <c:if test="${review_dto.rev_star eq 4}">--%>
            <%--                            <input type="radio" name="rev_star" value="1" id="rate1"><label--%>
            <%--                                for="rate1">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="2" id="rate2"><label--%>
            <%--                                for="rate2">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="3" id="rate3"><label--%>
            <%--                                for="rate3">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="4" id="rate4" checked><label--%>
            <%--                                for="rate4">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="5" id="rate5"><label--%>
            <%--                                for="rate5">★</label>--%>
            <%--                        </c:if>--%>

            <%--                        <c:if test="${review_dto.rev_star eq 5}">--%>
            <%--                            <input type="radio" name="rev_star" value="1" id="rate1"><label--%>
            <%--                                for="rate1">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="2" id="rate2"><label--%>
            <%--                                for="rate2">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="3" id="rate3"><label--%>
            <%--                                for="rate3">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="4" id="rate4"><label--%>
            <%--                                for="rate4">★</label>--%>
            <%--                            <input type="radio" name="rev_star" value="5" id="rate5" checked><label--%>
            <%--                                for="rate5">★</label>--%>
            <%--                        </c:if>--%>
            <%--                    </fieldset>--%>
            <%--                </div>--%>
            <%--            </div>--%>
            <%--            리뷰사진--%>
<%--            <div class="imgs">--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${not empty review_dto}">--%>
<%--                        <%--%>
<%--                            ReviewDTO reviewDTO = (ReviewDTO) request.getAttribute("review_dto");--%>
<%--                            String reviewSysName = reviewDTO.getRev_sysname();--%>
<%--                            //                            System.out.println("ddddddddddddddddddddddddddddddddd" + reviewSysName);--%>
<%--                            Gson gson = new Gson();--%>
<%--                            Type type = new TypeToken<List<String>>() {--%>
<%--                            }.getType();--%>
<%--                            request.setAttribute("review_img_list", gson.fromJson(reviewSysName, type));--%>
<%--                        %>--%>
<%--                        &lt;%&ndash;                        <c:forEach var="sysName" items="${review_img_list}">&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                            <div class="review_img_div">&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                                <img src="/resources/img/review/${sysName}">&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                                <input type="hidden" class="img_name" value="${sysName}">&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                                <button type="button" class="del_img_btn">지우기</button>&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                        </c:forEach>&ndash;%&gt;--%>
<%--                        <c:forEach var="store" items="${review_img_list}">--%>
<%--                            <div class="review_img_div">--%>
<%--                                <img src="/resources/img/review/${store}">--%>
<%--                                <input type="hidden" class="img_name" value="${store}">--%>
<%--                                <button type="button" class="del_img_btn">지우기</button>--%>
<%--                            </div>--%>
<%--                        </c:forEach>--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
<%--            </div>--%>

            <%--            <div><textarea name="rev_content" placeholder="솔직한 평가를 남겨주세요">${review_dto.rev_content}</textarea></div>--%>
            <%--            <div>글자수</div>--%>
            <%--            <div>--%>
            <%--                <div class="imgbox fileBtnBox">--%>
            <%--                    <input type="file" id="revImgBtn" name="files" accept=".png,.jpg,.jpeg,.gif" multiple>--%>
            <%--                </div>--%>
            <%--                <div id="new_file_name_list"></div>--%>
            <%--            </div>--%>
            <%--            <div>--%>
            <%--                <div> 주문한 메뉴</div>--%>
            <%--                <c:choose>--%>
            <%--                    <c:when test="${not empty menuNameList}">--%>
            <%--                        <c:forEach var="i" items="${menuNameList}">--%>
            <%--                            <div>${i}</div>--%>
            <%--                        </c:forEach>--%>
            <%--                    </c:when>--%>
            <%--                </c:choose>--%>
<%--                            <input type="text" value="${orders_dto.order_seq}" name="order_seq">--%>
<%--                            <input type="text" value="${orders_dto.acc_seq}" name="acc_seq">--%>
<%--                            <input type="text" value="${orders_dto.store_seq}" name="store_seq">--%>
<%--                            <input type="text" value="${orders_dto.order_price}">--%>
            <%--                <c:choose>--%>
            <%--                    <c:when test="${not empty orders_dto.menu_list}">--%>
            <%--                        &lt;%&ndash;                        <c:forEach var="sysName" items="${orders_dto.menu_list}">&ndash;%&gt;--%>
            <%--                        &lt;%&ndash;                        </c:forEach>&ndash;%&gt;--%>
            <%--                    </c:when>--%>
            <%--                </c:choose>--%>
            <%--            </div>--%>

            <div id="pageTitle">리뷰수정</div>
            <div id="storeName">${store_name}</div>
            <div id="starSec">
<%--                <fieldset id="starFiled">--%>
<%--                    <input type="radio" name="rev_star" value="5" id="rate1"><label--%>
<%--                        for="rate1" class="starCustom"><i class="fa-solid fa-star"></i></label>--%>
<%--                    <input type="radio" name="rev_star" value="4" id="rate2"><label--%>
<%--                        for="rate2" class="starCustom"><i class="fa-solid fa-star"></i></label>--%>
<%--                    <input type="radio" name="rev_star" value="3" id="rate3"><label--%>
<%--                        for="rate3" class="starCustom"><i class="fa-solid fa-star"></i></label>--%>
<%--                    <input type="radio" name="rev_star" value="2" id="rate4"><label--%>
<%--                        for="rate4" class="starCustom"><i class="fa-solid fa-star"></i></label>--%>
<%--                    <input type="radio" name="rev_star" value="1" id="rate5"><label--%>
<%--                        for="rate5" class="starCustom"><i class="fa-solid fa-star"></i></label>--%>
<%--                </fieldset>--%>

    <div class="star-rating space-x-4 mx-auto">
        <input type="radio" id="5-stars" class="star" name="rev_star" value="5" <c:if test="${review_dto.rev_star == '5'}">checked</c:if>>
        <label for="5-stars" class="startext pr-4"><i class="fa-solid fa-star"></i></label>
        <input type="radio" id="4-stars" class="star" name="rev_star" value="4"<c:if test="${review_dto.rev_star == '4'}">checked</c:if>>
        <label for="4-stars" class="startext"><i class="fa-solid fa-star"></i></label>
        <input type="radio" id="3-stars" class="star" name="rev_star" value="3"<c:if test="${review_dto.rev_star == '3'}">checked</c:if>>
        <label for="3-stars" class="startext"><i class="fa-solid fa-star"></i></label>
        <input type="radio" id="2-stars" class="star" name="rev_star" value="2"<c:if test="${review_dto.rev_star == '2'}">checked</c:if>>
        <label for="2-stars" class="startext"><i class="fa-solid fa-star"></i></label>
        <input type="radio" id="1-star" class="star" name="rev_star" value="1"<c:if test="${review_dto.rev_star == '1'}">checked</c:if>>
        <label for="1-star" class="startext"><i class="fa-solid fa-star"></i></label>
    </div>
            </div>










            <div>
                <textarea id="revContent" name="rev_content"
                          placeholder="솔직한 평가를 남겨주세요">${review_dto.rev_content}</textarea>
            </div>
            <div id="count">0 / 300</div>
            <div>
                <div class="imgBox fileBtnBox">
                    <input type="hidden" name="rev_sysname" id="rev_sysmname">
                    <label id="btnCustom"> <i class="fa-solid fa-camera"></i> 사진 추가
                        <input type="file" id="revImgBtn" name="files" accept=".png,.jpg,.jpeg,.gif"
                               multiple>
                    </label>
                </div>
                <div>
<%--                    <c:choose>--%>
<%--                        <c:when test="${not empty review_dto}">--%>
<%--                            <%--%>
<%--                                ReviewDTO reviewDTO = (ReviewDTO) request.getAttribute("review_dto");--%>
<%--                                String reviewSysName = reviewDTO.getRev_sysname();--%>
<%--                                System.out.println("ddddddddddddddddddddddddddddddddd" + reviewSysName);--%>
<%--                                Gson gson = new Gson();--%>
<%--                                Type type = new TypeToken<List<String>>() {--%>
<%--                                }.getType();--%>
<%--                                request.setAttribute("review_img_list", gson.fromJson(reviewSysName, type));--%>
<%--                            %>--%>
<%--                            &lt;%&ndash;                        <c:forEach var="sysName" items="${review_img_list}">&ndash;%&gt;--%>
<%--                            &lt;%&ndash;                            <div class="review_img_div">&ndash;%&gt;--%>
<%--                            &lt;%&ndash;                                <img src="/resources/img/review/${sysName}">&ndash;%&gt;--%>
<%--                            &lt;%&ndash;                                <input type="hidden" class="img_name" value="${sys--%>
<%--                            &lt;%&ndash;                                <button type="button" class="del_img_btn">지우기</but--%>
<%--                            &lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--                            &lt;%&ndash;                        </c:forEach>&ndash;%&gt;--%>
<%--                            <c:forEach var="store" items="${review_img_list}">--%>
<%--                                <div class="review_img_div">--%>
<%--                                    <img src="/resources/img/review/${store}">--%>
<%--                                    <input type="hidden" class="img_name" value="${store}">--%>
<%--                                    <button type="button" class="del_img_btn">지우기</button>--%>
<%--                                    <div class="imgName imgName1"><img id="img1" src=""></div>--%>
<%--                                </div>--%>
<%--                            </c:forEach>--%>
<%--                        </c:when>--%>
<%--                    </c:choose>--%>
                </div>
            </div>
            <hr>
            <div>
                <%--                주문번호: <input type="text" value="${dto.order_seq}" name="order_seq">--%>
                <%--                가게번호: <input type="text" value="${dto.store_seq}" name="store_seq">--%>
                <%--                주문금액: <input type="text" value="${dto.order_price}">--%>
                <%--                <input type="hidden" value="${dto.menu_list}" id="menu">--%>
                <div class="menuBox">주문 메뉴</div>
                <c:choose>
                    <c:when test="${not empty menuNameList}">
                        <c:forEach var="i" items="${menuNameList}">
                            <div class="menuList">${i}</div>
                        </c:forEach>
                    </c:when>
                </c:choose>

                <%--            <input type="text" value="${orders_dto.order_seq}" name="order_seq">--%>
                <%--            <input type="text" value="${orders_dto.acc_seq}" name="acc_seq">--%>
                <%--            <input type="text" value="${orders_dto.store_seq}" name="store_seq">--%>
                <%--            <input type="text" value="${orders_dto.order_price}">--%>
                <c:choose>
                    <c:when test="${not empty orders_dto.menu_list}">
                        <c:forEach var="sysName" items="${orders_dto.menu_list}">
                        </c:forEach>
                    </c:when>
                </c:choose>


            </div>
            <div id="btnBox">
                <button id="modifyBtn">수정완료</button>
                <button type="button" id="backBtn">취소</button>
            </div>
<%--            <div class="btns">--%>
<%--                <button id="modifyBtn">수정완료</button>--%>
<%--                <button type="button" id="cancleBtn">취소</button>--%>
<%--            </div>--%>

            <input type="text" id="rev_seq" name="rev_seq" value="${review_dto.rev_seq}">
            <input type="hidden" name="del_files_json" id="del_files_json">

                <input type="text" value="${orders_dto.order_seq}" name="order_seq">
<%--                <input type="hidden" value="${orders_dto.acc_seq}" name="acc_seq">--%>
                <input type="text" value="${orders_dto.store_seq}" name="store_seq">
        </form>
    </div>
</main>
<script src="/resources/js/member/myPage/modifyReview.js"></script>
</body>
</html>