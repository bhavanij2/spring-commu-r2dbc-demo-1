package com.example.springcommur2dbcdemo1.scorecard.repository;

import com.example.springcommur2dbcdemo1.scorecard.model.User;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

@Repository
public interface UserRespository extends ReactiveCrudRepository<User, String> {
    Flux<User> findByParentUserAndUserType(String parentUser, String userType);

    Flux<User> findByUserType(String userType);
}
