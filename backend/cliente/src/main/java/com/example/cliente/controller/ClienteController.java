package com.example.cliente.controller;

import com.example.cliente.excel.ClientExcelExporter;
import com.example.cliente.model.Cliente;
import com.example.cliente.service.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/cliente")
public class ClienteController {
    @Autowired
    private ClienteService service;

    @GetMapping
    private List<Cliente> findAll(){
        return service.findAll();
    }

    @GetMapping("/{id}")
    private Cliente findById(@PathVariable String id){
        return service.findByID(id);
    }

    @PostMapping
    private Cliente create (@RequestBody Cliente cliente) {
        return service.save(cliente);
    }

    @DeleteMapping("/clientes/{id}")
    public ResponseEntity<Cliente> deleteClient(@PathVariable String id){
        service.delete(id);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @GetMapping("/export/excel")
    public void exportToExcel(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        DateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=clientes_" + currentDateTime + ".xlsx";
        response.setHeader(headerKey, headerValue);

        Iterable<Cliente> listClients = service.findAll();

        ClientExcelExporter excelExporter = new ClientExcelExporter(listClients);

        excelExporter.export(response);
    }
}
