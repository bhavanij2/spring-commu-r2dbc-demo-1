package com.example.springcommur2dbcdemo1.scorecard.controller;

import com.example.springcommur2dbcdemo1.scorecard.dto.AccountDetails;
import com.example.springcommur2dbcdemo1.scorecard.model.UserType;
import com.example.springcommur2dbcdemo1.scorecard.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping
    public Flux<UserType> all() {
        return userService.findAllUserTypes();
    }

    @GetMapping("account-details")
    public Mono<AccountDetails> getAccountDetailsByUserName(@RequestParam("userName") String userName) {
        return userService.findAllAccountDetailsByUserName(userName);
    }
}
