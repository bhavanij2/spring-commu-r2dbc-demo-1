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
@Table("DIM_ACCOUNT")
public class Account {

    @Id
    private Long Id;
    private String accountName;
    private String district;
    private String zoneName;
    private String kam;
    private String idn;
}
