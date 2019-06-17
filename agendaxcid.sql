create table ia_similaridade_bruto 
(
    chave varchar2(200),
    tipo_item varchar2(200),
    item varchar2(200),
    valor number(9),
    ranking number(11,2)
)

create table ia_similaridade_max
(
    chave varchar2(200),
    tipo_item varchar2(200),
    maximo number(9)
)

delete from ia_similaridade_max
delete from ia_similaridade_bruto

--1) escolha
declare
  cursor cBruto is
    select agenda.cod_agenda chave, 'CID' tipo, cid.cod_cid item, count(*) valor
          from movimento, atendimento, atendimento_cid, cid, agendamento, vaga,agenda
         where movimento.seq_atendimento = atendimento.seq_atendimento
           and atendimento_cid.seq_atendimento = atendimento.seq_atendimento
           and atendimento_cid.seq_cid = cid.seq_cid
           and atendimento.seq_agendamento = agendamento.seq_agendamento
           and agendamento.seq_vaga = vaga.seq_vaga
           and vaga.seq_agenda = agenda.seq_agenda
           and atendimento.seq_encaminhamento is not null
           and movimento.dat_movimento > to_date('01/01/2019','DD/MM/RRRR')
           and agendamento.dat_hora_agendamento > to_date('01/01/2019','DD/MM/RRRR')
         group by agenda.cod_agenda, cid.cod_cid
         having count(*) > 100
           order by 1;
begin
  for x in  cBruto loop
    insert into ia_similaridade_bruto(chave, tipo_item, item, valor) values
           (x.chave, x.tipo, x.item, x.valor);
  end loop;
end;

--2)preparação
declare
  cursor cMax is
    select chave, tipo_item, sum(valor) maximo from ia_similaridade_bruto group by chave, tipo_item;
begin
  for x in  cMax loop
    insert into ia_similaridade_max(chave, tipo_item, maximo) values
           (x.chave, x.tipo_item, x.maximo);
  end loop;
end;

--ranking
declare
  cursor cSimi is
    select chave, tipo_item, item, valor from ia_similaridade_bruto;
    
  nMaximo number(9);  
  nRanking number(11,2);  
begin
  for x in  cSimi loop
    select maximo 
      into nMaximo
      from ia_similaridade_max 
     where chave=x.chave 
       and tipo_item=x.tipo_item;
       
     nRanking := x.valor/nMaximo;
     
     update ia_similaridade_bruto 
       set ranking = nRanking*100
      where chave=x.chave 
       and tipo_item=x.tipo_item
       and item=x.item;
  end loop;
end;

--teste
select chave, tipo_item, item, valor, ranking from ia_similaridade_bruto

declare
  cursor cCur is
    select chave, 
           item,
           ranking 
     from
      ia_similaridade_bruto
      order by 1;
   ChaveAnterior varchar2(200);
   primeira boolean;
begin
  ChaveAnterior:='-1';
  dbms_output.put_line('{');
  primeira :=true;
  
  for x in cCur loop
    if (x.chave<>ChaveAnterior) then
      if (primeira = false) then
         dbms_output.put_line('                  },');  
      end if;
      dbms_output.put_line('    '||''''||x.chave||''''||':');
    end if;
    if (ChaveAnterior<>x.chave) then
      dbms_output.put_line('        {'||''''||x.item||''''||':'||x.ranking);
    else
      dbms_output.put_line(',        '||''''||x.item||''''||':'||x.ranking);
    end if;
    ChaveAnterior := x.chave;
    primeira:=false;
  end loop;
  
  dbms_output.put_line('}');
  dbms_output.put_line('}');
end;   
 


/*
select * from procedimento_geral where cod_procedimento in  ('0405050364','0301100012')

select * from agenda where instr('1075@1952',lpad(cod_agenda,4,' ')) > 0

*/
 
