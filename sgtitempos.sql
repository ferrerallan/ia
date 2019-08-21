select  sum(round(BENNER,2)) BENNER,
        sum(round(ESTOQUE,2)) ESTOQUE ,
        sum(round(ANAMNESE,2)) ANAMNESE,
        sum(round(MICRO,2)) MICRO,
        sum(round(MONITO,2)) MONITO,
        sum(round(MOUSE,2)) MOUSE,
        sum(round(ACESS,2)) ACESS,
        sum(round(ERRO,2)) ERRO,
        sum(round(IMPRESSORA,2)) IMPRESSORA,
        sum(round(SIHOSP,2)) SIHOSP
  from
(
select DECODE(instr(UPPER(item_chamado.des_descricao),'BENNER'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) BENNER,      
       DECODE(instr(UPPER(item_chamado.des_descricao),'ESTOQUE'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) ESTOQUE,
       DECODE(instr(UPPER(item_chamado.des_descricao),'ANAMNESE'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) ANAMNESE,
       DECODE(instr(UPPER(item_chamado.des_descricao),'MICRO'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) MICRO,
       DECODE(instr(UPPER(item_chamado.des_descricao),'MONITOR'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) MONITO,
       DECODE(instr(UPPER(item_chamado.des_descricao),'MOUSE'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) MOUSE,
       DECODE(instr(UPPER(item_chamado.des_descricao),'ACESS'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) ACESS,
       DECODE(instr(UPPER(item_chamado.des_descricao),'ERRO'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) ERRO,
       DECODE(instr(UPPER(item_chamado.des_descricao),'IMPRESSORA'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) IMPRESSORA,
       DECODE(instr(UPPER(item_chamado.des_descricao),'SIHOSP'),0,0,(item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao)) SIHOSP,
       (item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao) tempo,
       centro_custo.nom_centro_custo,
       centro_custo.seq_centro_custo
  from chamado,item_chamado,grupo_resolutor,centro_custo
 where chamado.seq_chamado = item_chamado.seq_chamado 
   and chamado.dat_hora_chamado > sysdate -720 
   and item_chamado.seq_grupo_resolutor = grupo_resolutor.seq_grupo_resolutor
   and chamado.seq_centro_custo_solicita = centro_custo.seq_centro_custo
   and (item_chamado.dat_hora_conclusao)  is not null 
   and (item_chamado.dat_hora_conclusao-item_chamado.dat_hora_inclusao) between 1 and 12
              
  ) 
 where BENNER+ESTOQUE+ANAMNESE+MICRO+MONITO+MOUSE+ACESS+ERRO+IMPRESSORA+SIHOSP>0

