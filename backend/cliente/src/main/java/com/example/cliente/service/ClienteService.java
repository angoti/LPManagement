package com.example.cliente.service;

import com.example.cliente.model.Cliente;
import com.example.cliente.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClienteService {
    @Autowired
    private ClienteRepository repo;

    public List<Cliente> findAll(){
        return repo.findAll();
    }

    public Cliente findByID(String id){
        return repo.findById(id).get();
    }

    public Cliente save (Cliente cliente){
        return repo.save(cliente);
    }

    public void delete(String id){ repo.deleteById(id);}
}
