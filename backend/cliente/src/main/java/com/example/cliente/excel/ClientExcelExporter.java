package com.example.cliente.excel;

import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.example.cliente.model.Cliente;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


@SuppressWarnings("UnusedAssignment")
public class ClientExcelExporter {
    private final XSSFWorkbook workbook;
    private XSSFSheet sheet;
    private final Iterable<Cliente> listCliente;

    public ClientExcelExporter(Iterable<Cliente> listCliente) {
        this.listCliente = listCliente;
        workbook = new XSSFWorkbook();
    }

    private void writeHeaderLine() {
        sheet = workbook.createSheet("Clientes");

        Row row = sheet.createRow(0);

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        font.setFontHeight(16);
        style.setFont(font);

        createCell(row, 0, "Cliente ID", style);
        createCell(row, 1, "Nome Completo", style);
        createCell(row, 2, "Telefone", style);
        createCell(row, 3, "E-mail", style);
        createCell(row, 4, "Categoria de interesse", style);
        createCell(row, 5, "Data e hora do cadastro", style);
    }

    private void createCell(Row row, int columnCount, Object value, CellStyle style) {
        sheet.autoSizeColumn(columnCount);
        Cell cell = row.createCell(columnCount);
        if (value instanceof Long) {
            cell.setCellValue((Long) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        } else {
            cell.setCellValue((String) value);
        }
        cell.setCellStyle(style);
    }

    private void writeDataLines() {
        int rowCount = 1;

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeight(14);
        style.setFont(font);

        for (Cliente client : listCliente) {
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;

            createCell(row, columnCount++, client.getId(), style);
            createCell(row, columnCount++, client.getNome(), style);
            createCell(row, columnCount++, client.getEmail(), style);
            createCell(row, columnCount++, client.getTelefone(), style);
            createCell(row, columnCount++, client.getCategoriaDeMaiorInteresse(), style);
            createCell(row, columnCount++, client.getDateTime().toString(), style);
        }
    }

    public void export(HttpServletResponse response) throws IOException {
        writeHeaderLine();
        writeDataLines();

        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();

        outputStream.close();
    }
}