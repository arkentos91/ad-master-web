/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.arkentos.util.common;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;

/**
 *
 * @author jayana_i
 */
public class ExcelCommon {
    

 
    public static CellStyle getFontBoldedCell(SXSSFWorkbook workbook) {
        Font font = workbook.createFont();
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        return style;
    }

    public static CellStyle getFontBoldedUnderlinedCell(SXSSFWorkbook workbook) {
        Font font = workbook.createFont();
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        font.setUnderline(XSSFFont.U_SINGLE);
        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        return style;
    }

    public static CellStyle getColumnHeadeCell(SXSSFWorkbook workbook) {
        Font font = workbook.createFont();
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
        style.setBorderTop(XSSFCellStyle.BORDER_THIN);
        style.setBorderRight(XSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        return style;
    }

    public static CellStyle getRowColumnCell(SXSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        style.setBorderTop(XSSFCellStyle.BORDER_THIN);
        style.setBorderRight(XSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        return style;
    }

    public static CellStyle getAligneCell(SXSSFWorkbook workbook, XSSFCellStyle cellStyle, short alignment) {
        CellStyle style = workbook.createCellStyle();
        if (cellStyle != null) {
            style.cloneStyleFrom(cellStyle);
        }
        style.setAlignment(alignment);
        return style;
    }
    
}
