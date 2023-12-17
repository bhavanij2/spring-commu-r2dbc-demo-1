package com.example.springcommur2dbcdemo1.scorecard.dto;

import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class Idn {
    private String idnName;
    private List<AccountDto> accountDtos;
}