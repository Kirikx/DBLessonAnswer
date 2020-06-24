create
sequence lesson2._countries_id_seq;

alter table lesson2._countries rename column country_id to id;

alter
sequence lesson2._countries_id_seq owned by lesson2._countries.country_id;

alter table lesson2._countries rename column title_ru to title;

alter table lesson2._countries
    alter column title type varchar (150) using title:: varchar (150);

alter table lesson2._countries
    alter column title set not null;

alter table lesson2._countries
    drop column title_ua;

alter table lesson2._countries
    drop column title_be;

alter table lesson2._countries
    drop column title_en;

alter table lesson2._countries
    drop column title_es;

alter table lesson2._countries
    drop column title_pt;

alter table lesson2._countries
    drop column title_de;

alter table lesson2._countries
    drop column title_fr;

alter table lesson2._countries
    drop column title_it;

alter table lesson2._countries
    drop column title_pl;

alter table lesson2._countries
    drop column title_ja;

alter table lesson2._countries
    drop column title_lt;

alter table lesson2._countries
    drop column title_lv;

alter table lesson2._countries
    drop column title_cz;

create index _countries_title_index
    on lesson2._countries (title);

alter table lesson2._countries
    add constraint _countries_pk
        primary key (id);

alter table lesson2._countries
    alter column id set default nextval('lesson2._countries_id_seq');


create
sequence lesson2._regions_id_seq;

alter table lesson2._regions rename column region_id to id;

alter
sequence lesson2._regions_id_seq owned by lesson2._regions.region_id;

alter table lesson2._regions rename column title_ru to title;

alter table lesson2._regions
    alter column title set not null;

alter table lesson2._regions
    drop column title_ua;

alter table lesson2._regions
    drop column title_be;

alter table lesson2._regions
    drop column title_en;

alter table lesson2._regions
    drop column title_es;

alter table lesson2._regions
    drop column title_pt;

alter table lesson2._regions
    drop column title_de;

alter table lesson2._regions
    drop column title_fr;

alter table lesson2._regions
    drop column title_it;

alter table lesson2._regions
    drop column title_pl;

alter table lesson2._regions
    drop column title_ja;

alter table lesson2._regions
    drop column title_lt;

alter table lesson2._regions
    drop column title_lv;

alter table lesson2._regions
    drop column title_cz;

create index _regions_title_index
    on lesson2._regions (title);

alter table lesson2._regions
    add constraint _regions_pk
        primary key (id);

alter table lesson2._regions
    add constraint fk_countries
        foreign key (country_id) references lesson2._countries;

alter table lesson2._regions
    alter column id set default nextval('lesson2._regions_id_seq');


create
sequence lesson2._cities_id_seq;

alter table lesson2._cities rename column city_id to id;


alter
sequence lesson2._cities_id_seq owned by lesson2._cities.city_id;

-- Вот тут оставил как есть
alter table lesson2._cities
    alter column important type smallint using important:: smallint;

alter table lesson2._cities rename column title_ru to title;

alter table lesson2._cities
    alter column title set not null;

alter table lesson2._cities
    drop column area_ru;

alter table lesson2._cities
    drop column region_ru;

alter table lesson2._cities
    drop column title_ua;

alter table lesson2._cities
    drop column area_ua;

alter table lesson2._cities
    drop column region_ua;

alter table lesson2._cities
    drop column title_be;

alter table lesson2._cities
    drop column area_be;

alter table lesson2._cities
    drop column region_be;

alter table lesson2._cities
    drop column title_en;

alter table lesson2._cities
    drop column area_en;

alter table lesson2._cities
    drop column region_en;

alter table lesson2._cities
    drop column title_es;

alter table lesson2._cities
    drop column area_es;

alter table lesson2._cities
    drop column region_es;

alter table lesson2._cities
    drop column title_pt;

alter table lesson2._cities
    drop column area_pt;

alter table lesson2._cities
    drop column region_pt;

alter table lesson2._cities
    drop column title_de;

alter table lesson2._cities
    drop column area_de;

alter table lesson2._cities
    drop column region_de;

alter table lesson2._cities
    drop column title_fr;

alter table lesson2._cities
    drop column area_fr;

alter table lesson2._cities
    drop column region_fr;

alter table lesson2._cities
    drop column title_it;

alter table lesson2._cities
    drop column area_it;

alter table lesson2._cities
    drop column region_it;

alter table lesson2._cities
    drop column title_pl;

alter table lesson2._cities
    drop column area_pl;

alter table lesson2._cities
    drop column region_pl;

alter table lesson2._cities
    drop column title_ja;

alter table lesson2._cities
    drop column area_ja;

alter table lesson2._cities
    drop column region_ja;

alter table lesson2._cities
    drop column title_lt;

alter table lesson2._cities
    drop column area_lt;

alter table lesson2._cities
    drop column region_lt;

alter table lesson2._cities
    drop column title_lv;

alter table lesson2._cities
    drop column area_lv;

alter table lesson2._cities
    drop column region_lv;

alter table lesson2._cities
    drop column title_cz;

alter table lesson2._cities
    drop column area_cz;

alter table lesson2._cities
    drop column region_cz;

create index _cities_title_index
    on lesson2._cities (title);

alter table lesson2._cities
    add constraint _cities_pk
        primary key (id);

alter table lesson2._cities
    add constraint _cities__countries_id_fk
        foreign key (country_id) references lesson2._countries;

alter table lesson2._cities
    add constraint _cities__regions_id_fk
        foreign key (region_id) references lesson2._regions;

alter table lesson2._cities
    alter column id set default nextval('lesson2._cities_id_seq');
