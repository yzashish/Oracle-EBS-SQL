select * from all_tables where table_name like '%JE_BATCH%';

---balance by flexfield---

select   gcc.segment1
        ,gcc.segment2
        ,gcc.segment3
        ,gcc.segment4
        ,gcc.segment5,
         gjh.je_source
        ,gjh.je_category
        ,nvl(accounted_dr, 0)
        ,nvl(accounted_cr, 0)
        ,nvl(accounted_dr, 0) - nvl(accounted_cr,0) net
        ,gjl.description
from    apps.gl_je_lines gjl
        ,apps.gl_je_headers gjh
        ,apps.gl_je_batches gjb
        ,apps.gl_code_combinations gcc
where   gjl.code_combination_id = gcc.code_combination_id
and     gjh.je_batch_id = gjb.je_batch_id
and     gjh.je_header_id = gjl.je_header_id
--and     gjh.je_source = 'Inventory'
--and     gjl.description like '%75 Inventory%'
and     gjb.name like '%STD 76A%'
--and     gcc.segment2 in ('1020')
--and     gcc.segment3 in ('49004')
--and     gcc.segment4 in ('51605','51606','51607','51608','51301','57301','57302','57317','57401','57402','57409','57421','57422','57430')
--and       gcc.segment4 between '50000' and '99999'
--and     gcc.segment5 = '2626958'
--and     gcc.segment5 != '0000000'
--and     gjl.period_name in ('APR-11','MAY-11','JUN-11','JUL-11','AUG-11','SEP-11','OCT-11','NOV-11','DEC-11','JAN-12','FEB-12','MAR-12')
--and     gjl.period_name in ('APR-12','MAY-12','JUN-12','JUL-12','AUG-12','SEP-12','OCT-12','NOV-12','DEC-12','JAN-13','FEB-13','MAR-13')
--and     gjl.period_name in ('APR-08','MAY-08','JUN-08','JUL-08','AUG-08','SEP-08','OCT-08','NOV-08','DEC-08','JAN-09','FEB-09','MAR-09')
and     gjl.period_name = 'NOV-13'
--group by gcc.segment1, gcc.segment2, gcc.segment3, gcc.segment4, gcc.segment5; 
;


--summary total--

select  sum(nvl(accounted_dr, 0))
        ,sum(nvl(accounted_cr, 0))
        ,sum(nvl(accounted_cr, 0) - nvl(accounted_dr,0)) sum
from    apps.gl_je_lines gjl
        ,apps.gl_code_combinations gcc
where   gjl.code_combination_id = gcc.code_combination_id
--and     gcc.segment2 in ('0226','0227','0228','0235','0236','0237','0238','0240','0251','0462','0463')
--and     gcc.segment3 in ('40213','40252','50220','50222','70003','70004','70005','70006','70007','70008','70009','70010','70011','70012','70026','70196','70402','70404','70595','70597','71004','71006','71007','71008','71011','71023','72003','72004','72005','72198','72201','72202','72203','72204','72205','72206','72207','72208','72209','72210','72211','72212','72213','72214','72215','72216','72217','72218','72219','72231','72232','72233','72294','72296','72297','72298','72299','72301','72505','72801','72803','73101','73102','74001','75002','75003','75004','76002','76003','76102','76506')
--and     gcc.segment4 in ('51101','51102','51201','51301','51302','51303','51401','51402','51403','51404','51405','51406','51407','51420','51421','51501','51502','51503','51504','51505','51506','51507','51508','51509','51510','51511','51512','51520','51601','51602','51603','51604','51605','51606','51607','51608','51701','51702','51703','51801','51802','51803','51804','51805','51806','51807','51808','51809','51810','51901','52001','52002','52003','52004','52005','52006','52007','52008','52009','52010','52012','52013','52026','52101','52102','52103','52104','53101','53102','53103','53201','53202','53203','53204','53205','53209','53210','53211','53212','54101','54102','54103','54104','54201','54202','54203','54204','54205','54206','55101','55102','56001','57001','57017','57018','57020','57021','57022','57023','57306','59001','59002','60001','60002','60003','60004','60005','60006','60007','60008','60009','60010','60011','60012','60013','60014','60015','60050','60101','60102','60201','60202','60203','60204','60205','60206','60207','60208','60209','60210','60301','60302','60401','60501','60502','61001','61002','61003','61004','61005','61006','61007','61008','61009','61010','61011','61012','61013','61014','61015','61016','61017','61018','61019','61020','61021','61022','61023','62001','62002','62003','62004','62005','62006','62007','62008','62009','62010','62011','62012','63001','63002','63003','63004','63005','63006','63007','63008','63009','63010','63011','64001','64002','64003','64004','64005','64006','64007','64008','64009','64010','64011','64012','64013','64014','64015','64016','64017','64018','65101','65102','65103','65104','65105','65106','65107','65201','65202','65203','66101','66102','66103','66104','66105','66106','66107','66108','66109','66110','66111','66112','66201','66202','66203','66204','66301','66302','66303','66304','66305','66306','66307','66308','66309','66310','66311','66312','66401','66402','66403','66404','66405','67001','67002','67003','67004','67005','67006','67007','67008','67009','67010','67011','67012','67013','67020','67021','67022','67023','67024','67025','67026','67027','67028','67029','67030','67031','68101','68102','68103','68104','68105','68106','68107','68201','68202','68203','68204','68205','68206','68207','68208','68209','68210','68211','68212','68213','68214','68215','68216','68217','68218','68219','68220','68221','68222','68230','68250','68251','68252','68260','68261','68262','68263','68264','68301','68401','68402','68403','68404','68405','68406','69001','69002','69003','69101','69102','70001','70002','70003','70004','70005','70006','70007','70008','70009','70010','70011','70012','70013','70014','70015','70016','70017','70018','70019','70020','70021','70022','70100','71001','71002','71301','71302','72101','72102','72103','72104','81004','81006','81007','81010','81011','81020','81021','90000','91000','91100','91200','91201','91202','91203','91204','91205','91300','91301','92100','92101','92110','92111','92115','92116','92200','92201','92202','92203','92210','92211','92212','92213','92220','92221','92222','92223','92231','92232','92233','92234','92235','92236','92237','92238','92300','92301','92302','92303','92304','92305','92321','92322','92323','92324','92400','92401','92402','92403','92501','92503','93010','93011','93012','93013','93100','93101','93200','93201','93300','93301','93310','93311','93315','93316','93317','93318','93320','93321','93325','93326','93330','93331','93340','93341','93350','93351','93360','93361','93370','93371','93380','93381','93382','93383','93384','94101','94102','94103','94104','94105','94106','94107','94110','94111','95001','95002','95003','95004')
--and     gjl.period_name = 'OCT-12'
and       gcc.segment4 = '24404'
group by gcc.segment6;

---balance by flexfield---

select  gcc.segment1
        ,gcc.segment2
        ,gcc.segment3
        ,gcc.segment4
        ,gcc.segment5
        ,sum(nvl(accounted_dr, 0))
        ,sum(nvl(accounted_cr, 0))
        ,sum(nvl(accounted_dr, 0) - nvl(accounted_cr,0)) sum
from    apps.gl_je_lines gjl
        ,apps.gl_je_headers gjh
        ,apps.gl_code_combinations gcc
where   gjl.code_combination_id = gcc.code_combination_id
and     gjh.je_header_id = gjl.je_header_id
--and     gcc.segment2 in ()
--and     gcc.segment3 in ('40213','40252','50220','50222','70003','70004','70005','70006','70007','70008','70009','70010','70011','70012','70026','70196','70402','70404','70595','70597','71004','71006','71007','71008','71011','71023','72003','72004','72005','72198','72201','72202','72203','72204','72205','72206','72207','72208','72209','72210','72211','72212','72213','72214','72215','72216','72217','72218','72219','72231','72232','72233','72294','72296','72297','72298','72299','72301','72505','72801','72803','73101','73102','74001','75002','75003','75004','76002','76003','76102','76506')
--and     gcc.segment4 in ('72101','72102','72103','72104')
and       gcc.segment4 = '51806'
--and     gcc.segment5 in ('B170014')
and     gjl.period_name in ('APR-12', 'MAY-12', 'JUN-12', 'JUL-12', 'AUG-12', 'SEP-12', 'OCT-12', 'NOV-12', 'DEC-12', 'JAN-12')
group by gcc.segment1, gcc.segment2, gcc.segment3, gcc.segment4, gcc.segment5;  