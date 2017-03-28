package com.fh.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;


/**
 * @ClassName: SpecificationHelper.java
 * @Description: 
 * @author Guoce
 * @date 2017年3月20日下午5:56:42
 * 
 */
public class SpecificationHelper {
//
//    public static Sort buildSort(HttpServletRequest request) {
//        String sidx = request.getParameter("sidx");
//        if (StringUtils.isNotBlank(sidx)) {
//            if (request.getParameter("sord").equalsIgnoreCase("asc")) {
//                return new Sort(new Sort.Order(Sort.Direction.ASC, sidx));
//            } else {
//                return new Sort(new Sort.Order(Sort.Direction.DESC, sidx));
//            }
//        }
//        return null;
//    }
//
//    public static Sort buildIdDescSort() {
//        return new Sort(new Sort.Order(Sort.Direction.DESC, "id"));
//    }
//
//    public static Pageable buildPage(HttpServletRequest request) {
//        Integer pageNumber = Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("page"), "1"));
//        Integer pageRows = Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("rows"),
//                String.valueOf(GlobalConstants.DEFAULT_PAGESIZE)));
//
//        Pageable pageSpecification = new PageRequest(pageNumber - 1, pageRows, buildSort(request));
//        return pageSpecification;
//    }
//
//    public static Integer fetchPageNumber(HttpServletRequest request) {
//        return Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("page"), "1"));
//    }
//
//    public static Integer fetchPageRows(HttpServletRequest request) {
//        return Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("rows"),
//                String.valueOf(GlobalConstants.DEFAULT_PAGESIZE)));
//    }
//
//    //todo parse sort info
//
//    public static JsonModel buildJsonPage(Page pageResult, Pageable pageable) {
//        JsonModel jsonPage = new JsonModel();
//        jsonPage.page = pageable.getPageNumber() + 1;
//        jsonPage.total = (int) Math.ceil((double) pageResult.getTotalElements() / pageable.getPageSize());
//        jsonPage.records = (int) pageResult.getTotalElements();
//        jsonPage.rows = pageResult.getContent();
//
//        return jsonPage;
//    }
//
//    public static JsonModel buildEmptyPage() {
//        JsonModel jsonModel = new JsonModel();
//        jsonModel.page = 1;
//        jsonModel.total = 0;
//        jsonModel.records = 0;
//        jsonModel.rows = new ArrayList();
//        return jsonModel;
//    }
//
}
