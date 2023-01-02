<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>딜리 - 결제하기</title>
    <%@ include file="/WEB-INF/views/global/m-commonLib.jsp" %>
    <link rel="stylesheet" href="/resources/css/member/order/orderPay.css">

    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

</head>
<body>

<c:import url="/member/header/destination" />
<%@ include file="/WEB-INF/views/customHeader/m_home.jsp" %>
<%@ include file="/WEB-INF/views/customHeader/m_back.jsp" %>
<%@ include file="/WEB-INF/views/customHeader/m_header.jsp" %>

<main>
    <hr class="mt55">
<form name="dataForm" id="insertForm" action="/order/orders/insertOrder" method="post">

    <div class="container">
        <h2>배달 정보</h2>
        <hr>
        <div id="mainAddress">
            <input type="text" id="address1" name="address1" placeholder="Address1" readonly>
            <button type="button" id="destination_change">주소 변경</button>
            <div id="modal2" class="modal-overlay">
                <div class="modal-window">
                    <div class="title">
                        <h2>쿠폰리스트</h2>
                    </div>
                    <div class="close-area">X</div>
                    <div class="content" id="couponList">
                    </div>
                </div>
            </div>

        </div>
        <input type="text" id="address2" name="address2" placeholder="Address2">
        <input type="text" id="phoneNum" name="phoneNum" placeholder="phoneNum">
        <hr>
        <div>요청사항</div>
        <div style="border: 1px solid black; display: none;">
            <input type="checkbox" name="order_disposable" value="N">일회용 수저,포크 안주셔도 돼요!<br>
        </div>
        <input type="text" name="order_store_req" value="" placeholder="사장님한테 전달할 말">
        <input type="text" name="order_rider_req" value="" placeholder="라이더님한테 전달할 말">
        <hr>
        <div>결제수단
            <select id="payment" name="pay_method" onchange="onchangePayment()">
                <option name="payMethod" value="">선택</option>
                <option name="payMethod" value="kakaoPay">카카오페이</option>
                <option name="payMethod" value="creditCard">카드 결제</option>
            </select>
        </div>
        <hr>

        <%--할인쿠폰 리스트 모달--%>
        <div>
            <button type="button" id="btn_modal2">할인쿠폰</button>
            <span>선택할인쿠폰</span>
            <ul id="choiceCoupon">

            </ul>
        </div>
        <div>포인트
            <div>
                <input type="text" name="ownPoint" id="ownPoint" placeholder="보유포인트 0" readonly="true"
                       onchange="onchangeOwnPoint()">
                <input type="number" id="usePoint" name="usePoint" onchange="onchangeUsePoint()" placeholder="사용할 포인트" min="0">
            </div>
            <hr>
            <div>결제 금액</div>
            <div>주문 금액 출력
                <input type="text" id="order_price" name="order_price" readonly>
            </div>
            <div id="selectCoupon">쿠폰할인
                <input type="hidden" id="cp_seq" name="cp_seq">
                <input type="hidden" id="mc_seq" name="mc_seq">
                <input type="text" value=0 id="discountPrice" name="discountPrice" disabled="disabled"
                       placeholder="쿠폰 할인 금액 출력">
            </div>
            <div>포인트 할인
                <input type="text" value=0 id="use_point" name="use_point" placeholder="포인트 할인 출력" readonly>
            </div>
            <div>배달팁
                <input type="text" id="delivery_tip" name="delivery_tip" placeholder="배달팁" readonly>
            </div>
            <hr>
            <div>총 결제 금액 출력
                <input type="text" id="pay_price" name="pay_price" placeholder="총 결제 금액" readonly>
            </div>
            <hr>
            <div id="pay_method">
            <button type="button" id="payKakao" onclick="requestPay()">카카오 페이 결제</button>
            <button type="button" id="payCard" class="btn_payment">카드 결제</button>
            </div>
        </div>
        <input type="hidden" id="accEmail" name="accEmail" value="${userInfo.accEmail}"/>
        <input type="hidden" id="memName" name="memName" value="${userInfo.memName}"/>
        <input type="hidden" id="add_seq" name="add_seq"/>
    </div>
</form>
</main>
<script>
    var addSeq;
    var address1;
    var address2;
    var phoneNum;
    var ownPoint;
    var deliTip;


    window.onload = function () {
        $("#payCard").hide();
        $("#payment").val('kakaoPay');
        $("#acc_seq").val();
        $("#order_price").val(${orderOrdersDTO.order_price})
        $("#delivery_tip").val(${orderOrdersDTO.delivery_tip})
        initPage();
        setCouponList();
        var orderPrice = parseInt($("#order_price").val());
        var deliveryPrice = parseInt($("#delivery_tip").val());
        $("#pay_price").val(${orderOrdersDTO.order_price}+${orderOrdersDTO.delivery_tip});

    }

    // 글로벌 변수 및 페이지 초기화
    function initPage() {
        $.ajax({
            url: "/order/orders/selectInitInfo",
            type: "post",
            dataType: "json",
            success: function (data) {
                addSeq = data.add_seq;
                address1 = data.address1;
                address2 = data.address2;
                phoneNum = data.phoneNum;
                ownPoint = data.ownPoint;
                //deliTip = data.delivery_tip;

                $("#add_seq").val(addSeq);
                $("#address1").val(address1);
                $("#address2").val(address2);
                $("#phoneNum").val(phoneNum);
                $("#ownPoint").val(ownPoint);
                //$("#delivery_tip").val(deliTip);

                onchangeOwnPoint();
            },
            error: function (data) {
            }
        }).done(function (result) {

        });
    }

    function setCouponList() {
        $.ajax({
            url: "/order/orders/selectCouponList",
            type: "post",
            dataType: "json",
            success: function (data) {
                var html = "";
                if (data.length > 0) {
                    html += '<p>사용가능 쿠폰 목록</p>';
                    html += '<div> 쿠폰 이름 || 쿠폰 설명 || 할인율</div><br>';

                    for (var i = 0; i < data.length; i++) {
                        var type = '';
                        if (data[i].cpType == 'percent') type = '%';
                        else if(data[i].cpType == 'amount') type = '원';
                        // else (type = data[i].cpType);
                        html += '<a class="couponInfo" id="coupon' + i + '" href="javascript:choiceCoupon(' + i + ');">' + data[i].cpName + " || " + data[i].cpContent + " || " + data[i].discount_coupon + type + '</a><br>';
                        html += '<input type="hidden" value="' + data[i].cp_seq + '" id="cpSeq' + i + '"> ';
                        html += '<input type="hidden" value="' + data[i].cpName + '" id="cpName' + i + '"> ';
                        html += '<input type="hidden" value="' + data[i].discount_coupon + '" id="cpDiscount' + i + '"> ';
                        html += '<input type="hidden" value="' + data[i].cpType + '" id="cpType' + i + '"> ';
                        html += '<input type="hidden" value="' + data[i].mc_seq + '" id="mcSeq' + i + '"> ';
                    }

                } else {
                    html += '<p>사용 가능한 쿠폰이 없습니다.</p>';
                }
                $("#couponList").html(html);
            },
            error: function (data) {
                $("#couponList").html('<p>사용 가능한 쿠폰이 없습니다.</p>');
            }
        }).done(function (result) {

        });
    }

    function choiceCoupon(param) {
        //넘겨줘야하는 거 ==> 쿠폰 이름, 시퀀스, 할인율 (discount, type)
        var cpName = $("#cpName" + param).val();
        var cpSeq = $("#cpSeq" + param).val();
        var cpDiscount = $("#cpDiscount" + param).val();
        var cpType = $("#cpType" + param).val();
        var mcSeq = $("#mcSeq" + param).val();

        var html = "";
        html += "<li id='chCp' cpSeq = '" + cpSeq + "' cpName = '" + cpName + "' cpDiscount = '" + cpDiscount + "' cpType = '" + cpType + "'>" + cpName + "</li>";

        $("#choiceCoupon").html(html);
        var modal2 = document.getElementById('modal2');
        modal2.style.display = "none";
        $("#cp_seq").val(cpSeq);
        $("#mc_seq").val(mcSeq);
        // 결제금액 출력
        var orderPrice = Number($("#order_price").val());
        console.log(orderPrice);
        // var discountPrice = $("#discount_coupon").val();
        // var discountPrice = orderPrice * (1 - cpName.replace(/\D/g,'')/100);
        if(cpType == 'percent') {
            var discountPrice = Math.floor(orderPrice * Number(cpDiscount) / 100);
        }else {
            var discountPrice = Math.floor(Number(cpDiscount));
        }
        var usePoint = Number($("#use_point").val());
        var deliveryTip = Number($("#delivery_tip").val());
        var payPrice = orderPrice - (discountPrice + usePoint) + deliveryTip;
        console.log(cpDiscount);
        console.log(cpType);
        console.log(usePoint);
        console.log(payPrice);
        if(payPrice < 0){
            payPrice = 0;
        }
        $("#discountPrice").val(discountPrice);
        $("#pay_price").val(payPrice);
        // $("#discountPrice").val(discountPrice);
        // $("#discount_coupon").val(discountPrice);
        // $("#discount_coupon").text(discountPrice);

        /*
        * 쿠폰 정보 빼오는 방법
        *
        * $("#chCp").attr('cpSeq'); ==> 하면 li 태그에 저장해둔 쿠폰 시퀀스 가져올 수 있다.
        * */
    }

    function onclickBtnChgAddr() {
        var postCd = $("#postcode").val();
        var address1 = $("#add1").val();
        var address2 = $("#add2").val();
        var msg = "";
        var inptFlag = 0;

        if (postCd == "") {
            msg = "우편번호";
            inptFlag = 1;
        }
        if (address1 == "") {
            msg = "도로명/지번";
            inptFlag = 1;
        }
        if (address2 == "") {
            msg = "상세주소";
            inptFlag = 1;
        }
        if (inptFlag == 1) {
            msg += "을/를 입력해주세요.";
            alert(msg);
            return;
        } else {
            $.ajax({
                url: "/order/orders/updateMemberAddr",
                type: "post",
                dataType: "json",
                data: {
                    acc_seq: accSeq,
                    address1: address1,
                    address2: address2
                },
                success: function (e) {
                    if (e == 1) {
                        alert("주소가 변경되었습니다.")
                        var modal = document.getElementById('modal');
                        modal.style.display = "none";
                        $("#address1").val(address1);
                        $("#address2").val(address2);
                    }
                },
                error: function () {
                }
            }).done(function () {
                // alert("주소변경 되었습니다.");
                // location.href="/home";
            });
        }
    }

    // function onclickBtnChgPhone() {
    //     var phoneNumber = $("#phoneNumber").val();
    //     var msg = "";
    //     var inptFlag = 0;
    //
    //     if (phoneNumber == "") {
    //         msg = "핸드폰 번호";
    //         inptFlag = 1;
    //     }
    //     if (inptFlag == 1) {
    //         msg += "을/를 입력해주세요.";
    //         alert(msg);
    //         return;
    //     } else {
    //         $.ajax({
    //             url: "orders/updateMemberPhone",
    //             type: "post",
    //             dataType: "json",
    //             data: {
    //                 phoneNum: phoneNumber
    //             },
    //             success: function (e) {
    //                 if (e == 1) {
    //                     alert("핸드폰 번호가 변경되었습니다.")
    //                     var modal3 = document.getElementById('modal3');
    //                     modal3.style.display = "none";
    //                     $("#phoneNumber").val(phoneNumber);
    //                 }
    //             },
    //             error: function (e) {
    //             }
    //         }).done(function () {
    //             //alert("핸드폰 변경이 완료되었습니다.");
    //             //location.href="/";
    //         })
    //     }
    // }

    function onchangePayment() {
        $("#payKakao").hide();
        $("#payCard").hide();
        var payMth = $("#payment").val();
        switch (payMth) {
            case "" :
                break;
            case "kakaoPay" :
                $("#payKakao").show();
                break;
            case "creditCard" :
                $("#payCard").show();
                break;
        }
    }

    function onchangeOwnPoint() {
        if (ownPoint == "0") {
            $("#usePoint").attr('readonly', true);
            $("#usePoint").attr('placeholder', '사용 가능 포인트가 없습니다');
            $("#usePoint").val(0);
        } else {
            $("#usePoint").removeAttr('readonly');
            $("#usePoint").attr('placeholder', '사용하실 포인트를 입력해주세요.');
        }
    }

    function onchangeUsePoint() {
        var orderPrice = Number($("#order_price").val());
        var usePoint = Number($("#usePoint").val());
        if(usePoint > ownPoint){
            usePoint = ownPoint;
            $("#usePoint").val(ownPoint);
        }else if (usePoint < 0) {
            usePoint = 0;
            $("#usePoint").val(0);
        }

        let cpDiscount = Number($("#discountPrice").val());
        $("#use_point").val(usePoint);
        var deliveryTip = Number($("#delivery_tip").val());
        var payPrice = (orderPrice + deliveryTip) - usePoint - cpDiscount;
        $("#pay_price").val(payPrice);
    }

    // 버튼 클릭 시 쿠폰리스트 모달창 오픈
    const modal2 = document.getElementById("modal2");
    const btnModal2 = document.getElementById("btn_modal2");
    btnModal2.addEventListener("click", e => {
        modal2.style.display = "flex"
    })

    // 쿠폰리스트 모달창 클로즈(X) 버튼 누를시 모달 종료
    const closeBtn2 = modal2.querySelector(".close-area")
    closeBtn2.addEventListener("click", e => {
        modal2.style.display = "none"
    })

    // 쿠폰리스트 모달창 바깥 영역 클릭 시 모달 종료
    modal2.addEventListener("click", e => {
        const evTarget = e.target
        if (evTarget.classList.contains("modal-overlay")) {
            modal2.style.display = "none"
        }
    })

    //  모달창 켜진 상태에서 ESC 버튼 클릭시 모달 종료
    window.addEventListener("keyup", e => {
        if (modal2.style.display === "flex" && e.key === "Escape") {
            modal2.style.display = "none"
        }
    })

    // kg 이니시스 결제
    $(".btn_payment").click(function () {
        IMP.init("imp52685667");
        //결제시 전달되는 정보
        var email = $("#accEmail").val();
        var name = $("#memName").val();
        var phoneNum = $("#phoneNum").val();
        var address = $("#add1").val() + " " + $("#add2").val();
        var payPrice = $("#pay_price").val();

        IMP.request_pay({
            pg: 'html5_inicis',
            pay_method: 'card',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '결제',// 상품명,
            amount: 100,//상품 가격,
            buyer_email: email,//구매자 이메일,
            buyer_name: name,
            buyer_tel: phoneNum,//구매자 연락처
            buyer_addr: address,//구매자 주소

        }, function (rsp) {
            var result = '';
            if (rsp.success) {
                $("#insertForm").submit();
                var msg = '결제가 완료되었습니다.';

            } else {
                var msg = '결제에 실패하였습니다.';

            }
            alert(msg);
        });
    });


    // 카카오페이 결제
    var IMP = window.IMP;
    IMP.init("imp52685667");

    function requestPay() {
        var email = $("#accEmail").val();
        var name = $("#memName").val();
        var phoneNum = $("#phoneNum").val();
        var address = $("#add1").val() + " " + $("#add2").val();
        var payPrice = $("#pay_price").val();

        //결재정보  JSON
        var payInfo = {
            pg: 'kakaopay',
            pay_method: 'card',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '결제',
            amount: 100,//'가격 입력',
            buyer_email: email,//'구매자 이메일',
            buyer_name: name,//'구매자 이름'
            buyer_tel: phoneNum,
            buyer_addr: address
        };

        IMP.request_pay(payInfo, function (rsp) {
            if (rsp.success) {

                var msg = '결제가 완료되었습니다.';
                $("#insertForm").submit();

            } else {
                var msg = '결제에 실패하였습니다.';
            }
            alert(msg);
        });
    }

</script>

</body>
</html>
