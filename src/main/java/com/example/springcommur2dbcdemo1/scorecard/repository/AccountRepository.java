package com.example.springcommur2dbcdemo1.scorecard.repository;

import com.example.springcommur2dbcdemo1.scorecard.model.Account;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

@Repository
public interface AccountRepository extends ReactiveCrudRepository<Account, Long> {
    public Flux<Account> findByKam(String kamName);
}
