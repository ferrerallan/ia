select 'I' tipo,
       id_paciente,
       dat_hora_internacao dat_hora_contato_assistencial,
       cod_sexo sexo,
       idade,
       nom_unidade_saude,
       nom_centro_custo prestadora,
       ala ,
       case when instr( ala,'UTI')>0 then 'S' ELSE 'N' END UTI,
       dat_obito,
       dias_permanencia,
       cid_principal_entrada,
       cid_entrada_secundario,
       cid_final_principal,
       cid_final_secundario,
       des_historia
       
 from 
(
select anamnese_internacao.des_historia,
       pessoa.cod_sexo,
       centro_custo.nom_centro_custo,
       sihosp.get_nom_infra(leito_historico.seq_infra_estrutura) ala,
       pessoa.dat_obito,
       round((sysdate - pessoa.dat_nascimento)/365,2) idade,
       unidade_saude.nom_unidade_saude,
       round( NVL(internacao.dat_hora_saida,sysdate)-internacao.dat_hora_internacao,2) dias_permanencia  ,
       dat_hora_internacao    ,
       cid_principal_entrada.cod_cid||'-'||cid_principal_entrada.nom_cid cid_principal_entrada,
       cid_final_principal.cod_cid||'-'||cid_final_principal.nom_cid cid_final_principal,
       cid_final_secundario.cod_cid||'-'||cid_final_secundario.nom_cid cid_final_secundario,
       cid_entrada_secundario.cod_cid||'-'||cid_entrada_secundario.nom_cid cid_entrada_secundario,
       paciente.seq_paciente id_paciente
  from internacao 
  inner join paciente on (internacao.seq_paciente = paciente.seq_paciente)
  inner join movimentacao_internacao on (internacao.seq_internacao = movimentacao_internacao.seq_internacao)
  inner join centro_custo on (movimentacao_internacao.seq_centro_custo = centro_custo.seq_centro_custo)
  inner join pessoa on (paciente.seq_pessoa = pessoa.seq_pessoa)
  inner join leito_historico on (movimentacao_internacao.seq_leito = leito_historico.seq_leito)
  inner join epicrise on (internacao.seq_internacao = epicrise.seq_internacao)
  inner join anamnese_internacao on (internacao.seq_internacao = anamnese_internacao.seq_internacao)
  left outer join cid cid_principal_entrada on (epicrise.seq_cid_entrada_principal = cid_principal_entrada.seq_cid)
  left outer join cid cid_final_principal on (epicrise.seq_cid_final_principal = cid_final_principal.seq_cid)
  left outer join cid cid_final_secundario on (epicrise.seq_cid_final_secundario = cid_final_secundario.seq_cid)
  left outer join cid cid_entrada_secundario on (epicrise.seq_cid_entrada_secundario = cid_entrada_secundario.seq_cid)
  left outer join unidade_saude on (paciente.seq_unidade_saude = unidade_saude.seq_unidade_saude)
 where internacao.seq_movimentacao_atual = movimentacao_internacao.seq_movimentacao_internacao
   and (    epicrise.seq_cid_final_principal in (select seq_cid from cid where des_tag like '%#COVID%')
         OR epicrise.seq_cid_entrada_principal in (select seq_cid from cid where des_tag like '%#COVID%')
         OR epicrise.seq_cid_final_secundario in (select seq_cid from cid where des_tag like '%#COVID%') 
         OR epicrise.seq_cid_entrada_secundario in (select seq_cid from cid where des_tag like '%#COVID%') )

   and internacao.dat_hora_internacao >  to_date('01/01/2020','DD/MM/RRRR')
   )
   
union all


select 'E' tipo,
       id_paciente,
       dat_hora_internacao dat_hora_contato_assistencial,
       cod_sexo sexo,
       idade,
       nom_unidade_saude,
       nom_centro_custo prestadora,
       ala ,
       case when instr( ala,'UTI')>0 then 'S' ELSE 'N' END UTI,
       dat_obito,
       dias_permanencia,
       cid_principal_entrada,
       cid_entrada_secundario,
       cid_final_principal,
       cid_final_secundario,
       des_historia
       
 from 
(
select evolucao_internacao.des_evolucao des_historia,
       pessoa.cod_sexo,
       centro_custo.nom_centro_custo,
       sihosp.get_nom_infra(leito_historico.seq_infra_estrutura) ala,
       pessoa.dat_obito,
       round((sysdate - pessoa.dat_nascimento)/365,2) idade,
       unidade_saude.nom_unidade_saude,
       round( NVL(internacao.dat_hora_saida,sysdate)-internacao.dat_hora_internacao,2) dias_permanencia  ,
       dat_hora_internacao    ,
       cid_principal_entrada.cod_cid||'-'||cid_principal_entrada.nom_cid cid_principal_entrada,
       cid_final_principal.cod_cid||'-'||cid_final_principal.nom_cid cid_final_principal,
       cid_final_secundario.cod_cid||'-'||cid_final_secundario.nom_cid cid_final_secundario,
       cid_entrada_secundario.cod_cid||'-'||cid_entrada_secundario.nom_cid cid_entrada_secundario,
       paciente.seq_paciente id_paciente
  from internacao 
  inner join paciente on (internacao.seq_paciente = paciente.seq_paciente)
  inner join movimentacao_internacao on (internacao.seq_internacao = movimentacao_internacao.seq_internacao)
  inner join centro_custo on (movimentacao_internacao.seq_centro_custo = centro_custo.seq_centro_custo)
  inner join pessoa on (paciente.seq_pessoa = pessoa.seq_pessoa)
  inner join leito_historico on (movimentacao_internacao.seq_leito = leito_historico.seq_leito)
  inner join epicrise on (internacao.seq_internacao = epicrise.seq_internacao)
  inner join anamnese_internacao on (internacao.seq_internacao = anamnese_internacao.seq_internacao)
  inner join evolucao_internacao on (evolucao_internacao.seq_internacao = internacao.seq_internacao and
                                     evolucao_internacao.seq_anamnese_internacao = anamnese_internacao.seq_anamnese_internacao)

  left outer join cid cid_principal_entrada on (epicrise.seq_cid_entrada_principal = cid_principal_entrada.seq_cid)
  left outer join cid cid_final_principal on (epicrise.seq_cid_final_principal = cid_final_principal.seq_cid)
  left outer join cid cid_final_secundario on (epicrise.seq_cid_final_secundario = cid_final_secundario.seq_cid)
  left outer join cid cid_entrada_secundario on (epicrise.seq_cid_entrada_secundario = cid_entrada_secundario.seq_cid)
  left outer join unidade_saude on (paciente.seq_unidade_saude = unidade_saude.seq_unidade_saude)
 where internacao.seq_movimentacao_atual = movimentacao_internacao.seq_movimentacao_internacao
   and (    epicrise.seq_cid_final_principal in (select seq_cid from cid where des_tag like '%#COVID%')
         OR epicrise.seq_cid_entrada_principal in (select seq_cid from cid where des_tag like '%#COVID%')
         OR epicrise.seq_cid_final_secundario in (select seq_cid from cid where des_tag like '%#COVID%') 
         OR epicrise.seq_cid_entrada_secundario in (select seq_cid from cid where des_tag like '%#COVID%') )

   and internacao.dat_hora_internacao >  to_date('01/01/2020','DD/MM/RRRR')
   )
   
 union all

select 'A' tipo,
       paciente.seq_paciente id_paciente,
        atendimento.dat_hora_atendimento dat_hora_contato_assistencial,
       cod_sexo sexo,
       round((sysdate - pessoa.dat_nascimento)/365,2) idade,
       unidade_saude.nom_unidade_saude,
       nom_centro_custo prestadora,
       'N' ala ,
       'N' UTI,
       pessoa.dat_obito,
       (atendimento.dat_hora_encaminhamento-atendimento.dat_hora_atendimento) /365 dias_permanencia,
       (select max(cod_cid||'-'||nom_cid) 
         from atendimento_cid 
         inner join cid on (atendimento_cid.seq_cid=
                            cid.seq_cid )
         where atendimento_cid.seq_atendimento = atendimento.seq_atendimento)cid_principal_entrada ,
           
       'N' cid_entrada_secundario,
       'N' cid_final_principal,
       'N' cid_final_secundario,
       anamnese.des_historia
  from atendimento inner join paciente on (atendimento.seq_paciente = paciente.seq_paciente)
       inner join centro_custo on (atendimento.seq_centro_custo_realiza= centro_custo.seq_centro_custo)
       inner join pessoa on (paciente.seq_pessoa = pessoa.seq_pessoa)
       left outer join unidade_saude on (paciente.seq_unidade_saude = unidade_saude.seq_unidade_saude)
       left outer join anamnese on (atendimento.seq_atendimento = anamnese.seq_atendimento)
 where atendimento.flg_suspeita_corona=1
   and atendimento.dat_hora_atendimento > to_date('01/01/2020','DD/MM/RRRR')
   
 union all 
 
 select 'AC' tipo,
        paciente.seq_paciente id_paciente,
        atendimento.dat_hora_atendimento dat_hora_contato_assistencial,
       cod_sexo sexo,
       round((sysdate - pessoa.dat_nascimento)/365,2) idade,
       unidade_saude.nom_unidade_saude,
       nom_centro_custo prestadora,
       'N' ala ,
       'N' UTI,
       pessoa.dat_obito,
       (atendimento.dat_hora_encaminhamento-atendimento.dat_hora_atendimento) /365 dias_permanencia,
       (select max(cod_cid||'-'||nom_cid) 
         from atendimento_cid 
         inner join cid on (atendimento_cid.seq_cid=
                            cid.seq_cid )
         where atendimento_cid.seq_atendimento = atendimento.seq_atendimento)cid_principal_entrada ,
           
       'N' cid_entrada_secundario,
       'N' cid_final_principal,
       'N' cid_final_secundario,
       anamnese.des_historia
  from atendimento inner join paciente on (atendimento.seq_paciente = paciente.seq_paciente)
       inner join centro_custo on (atendimento.seq_centro_custo_realiza= centro_custo.seq_centro_custo)
       inner join pessoa on (paciente.seq_pessoa = pessoa.seq_pessoa)
       left outer join unidade_saude on (paciente.seq_unidade_saude = unidade_saude.seq_unidade_saude)
       inner join atendimento_cid on (atendimento.seq_atendimento = atendimento_cid.seq_atendimento) 
       inner join cid on (atendimento_cid.seq_cid = cid.seq_cid)
       left outer join anamnese on (atendimento.seq_atendimento = anamnese.seq_atendimento)
 where atendimento.dat_hora_atendimento >  to_date('01/01/2020','DD/MM/RRRR')
   and cid.des_tag like '%#COVID%'
 
 
