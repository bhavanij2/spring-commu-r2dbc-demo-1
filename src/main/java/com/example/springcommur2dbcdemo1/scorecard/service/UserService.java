package com.example.springcommur2dbcdemo1.scorecard.service;

import com.example.springcommur2dbcdemo1.scorecard.dto.*;
import com.example.springcommur2dbcdemo1.scorecard.model.Account;
import com.example.springcommur2dbcdemo1.scorecard.model.UserType;
import com.example.springcommur2dbcdemo1.scorecard.repository.AccountRepository;
import com.example.springcommur2dbcdemo1.scorecard.repository.UserRespository;
import com.example.springcommur2dbcdemo1.scorecard.repository.UserTypeRepository;
import io.vavr.collection.List;
import io.vavr.collection.Map;
import io.vavr.collection.Set;
import io.vavr.control.Option;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
public class UserService {

    @Autowired
    private UserTypeRepository userTypeRepository;

    @Autowired
    private UserRespository userRespository;

    @Autowired
    private AccountRepository accountRepository;

    public Flux<UserType> findAllUserTypes() {
        return userTypeRepository.findAll();
    }

    public Mono<AccountDetails> findAllAccountDetailsByUserName(String userName) {
        return accountRepository.findByKam(userName)
                .collectList()
                .map(List::ofAll)
                .map(userList -> userList.groupBy(Account::getZoneName)
                                        .mapValues(zoneGroup -> zoneGroup.groupBy(Account::getDistrict)
                                            .mapValues(districtGroup -> districtGroup.groupBy(Account::getIdn)))
                )
                .map(this::mapToAccountDetailsDto);
    }

    private AccountDetails mapToAccountDetailsDto(Map<String, Map<String, Map<String, List<Account>>>> groupMap) {
        List<Zone> zones = groupMap.keySet().map(zoneKey -> {
            Map<String, Map<String, List<Account>>> zoneGroup = groupMap.get(zoneKey).get();

            Zone zone = new Zone();
            zone.setZoneName(zoneKey);

            List<District> districts = zoneGroup.keySet().map(districtKey -> {
                Map<String, List<Account>> districtGroup = zoneGroup.get(districtKey).get();

                District district = new District();
                district.setDistrictName(districtKey);

                List<Idn> idns = districtGroup.keySet().map(idnKey -> {
                    List<Account> idnGroup = districtGroup.get(idnKey).get();

                    Idn idn = new Idn();
                    idn.setIdnName(idnKey);

                    List<AccountDto> accountDtos = idnGroup.map(elem -> new AccountDto(elem.getAccountName(), elem.getKam()));
                    idn.setAccountDtos(accountDtos.asJava());

                    return idn;
                }).toList();

                district.setIdns(idns.asJava());
                return district;
            }).toList();

            zone.setDistricts(districts.asJava());
            return zone;
        }).toList();

        AccountDetails accountDetails = new AccountDetails();
        accountDetails.setZones(zones.asJava());

        return accountDetails;
    }

}

