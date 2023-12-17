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
@Table("DIM_USER")
public class User {
    @Id
    private String userName;
    private String parentUser;
    private String userType;
    private String district;
}
