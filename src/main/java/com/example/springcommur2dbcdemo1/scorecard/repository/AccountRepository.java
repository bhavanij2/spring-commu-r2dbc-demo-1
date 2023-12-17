package com.example.springcommur2dbcdemo1.scorecard.repository;

import com.example.springcommur2dbcdemo1.scorecard.model.Account;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

import java.util.List;

@Repository
public interface AccountRepository extends ReactiveCrudRepository<Account, Long> {
    Flux<Account> findByKam(String kamName);

    Flux<Account> findByKamIn(List<String> kamNames);

}
