package com.example.springcommur2dbcdemo1.scorecard.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table("DIM_USER_TYPE")
public class UserType {

    @Id
    private String userType;
    private String userTypeDesc;
}
