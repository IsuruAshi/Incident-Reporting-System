package lk.ijse.dep11.web.to;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Incident implements Serializable {
    private String id;
    private Date date;
    private String incident;
    private String description;
    private String location;
    private String reporting_person;
    private String pictureUrl;
}
