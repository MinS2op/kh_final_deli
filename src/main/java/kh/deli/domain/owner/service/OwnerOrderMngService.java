package kh.deli.domain.owner.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kh.deli.domain.member.store.dto.BasketMenu;
import kh.deli.domain.member.store.dto.StoreBasketMenuRequestDTO;
import kh.deli.domain.member.store.service.StoreBasketService;
import kh.deli.domain.owner.dto.OwnerOrderMngRequestDTO;
import kh.deli.domain.owner.dto.OwnerOrderMngResponseDTO;
import kh.deli.global.entity.MenuOptionDTO;
import kh.deli.global.util.naverSensV2.NaverNShortURL;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class OwnerOrderMngService {
    private final OwnerOrdersService ordersService;
    private final StoreBasketService basketService;

    private final Gson gson;

    public List<OwnerOrderMngResponseDTO> getOrderMngResponseDTO(int storeSeq) {
        List<OwnerOrderMngRequestDTO> orderMngReqList = ordersService.getOrderMngList(storeSeq);

        List<OwnerOrderMngResponseDTO> orderMngList = new ArrayList<>();
        NaverNShortURL nShortURL = new NaverNShortURL();

        for (OwnerOrderMngRequestDTO orderMngReq : orderMngReqList) {
            String address = orderMngReq.getAdd_detail1() + " " + orderMngReq.getAdd_detail2();

            String link = "http://localhost/deliveryDtl/" + orderMngReq.getOrder_seq();
            nShortURL.toShortURL(link);

            Type type = new TypeToken<List<StoreBasketMenuRequestDTO>>(){}.getType();
            List<StoreBasketMenuRequestDTO> basketMenuDtoList = gson.fromJson(orderMngReq.getMenu_list(), type);

//            Basket basket = basketService.basketDtoToObject();
            List<BasketMenu> basketMenuList = basketService.basketMenuListDtoToObject(basketMenuDtoList);

            List<String> menuStrList = new ArrayList<>();

            // 메뉴명 및 옵션 String 만들기
            for (BasketMenu basketMenu : basketMenuList) {
                StringBuilder menuStr = new StringBuilder();

                // 메뉴명 및 개수
                menuStr.append(basketMenu.getMenu().getMenu_name());
                menuStr.append(": " + basketMenu.getCount() + "개 - ");

                for (MenuOptionDTO option : basketMenu.getOptionList()) {
                    menuStr.append(option.getOption_name()+" ");
                }

                menuStrList.add(menuStr.toString());
            }

            orderMngList.add(
                    OwnerOrderMngResponseDTO.builder()
                            .orderSeq(orderMngReq.getOrder_seq())
                            .status(orderMngReq.getOrder_status())
                            .memberName(orderMngReq.getMem_name())
                            .menuStrList(menuStrList)
                            .address(address)
                            .phone(orderMngReq.getMem_phone())
                            .link(link)
                            .build()
            );
        }

        return orderMngList;
    }
}