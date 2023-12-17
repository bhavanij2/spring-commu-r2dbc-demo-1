package com.example.springcommur2dbcdemo1.scorecard.service;

import com.example.springcommur2dbcdemo1.scorecard.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;

    public void getAccountDetailsByUser(String userName) {

    }
}
