package com.example.springcommur2dbcdemo1.scorecard.repository;

import com.example.springcommur2dbcdemo1.scorecard.model.UserType;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserTypeRepository extends ReactiveCrudRepository<UserType, String> {

}
