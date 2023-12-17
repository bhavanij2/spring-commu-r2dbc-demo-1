package com.example.springcommur2dbcdemo1.scorecard.repository;

import com.example.springcommur2dbcdemo1.scorecard.model.User;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRespository extends ReactiveCrudRepository<User, String> {
}
