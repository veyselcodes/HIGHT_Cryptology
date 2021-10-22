%%%%
%% HIGHT : Enxample of test vectors
%%%%
clear all;clc;

source('HIGHT_lib.m');

%%%%
%%  Example of test vectors
%%%%
%MSG='0000000000000000';
%Key='00112233445566778899aabbccddeeff';
MSG='F43FB7FF969696D7';
Key='F43FB7FF9696D7AD55E687A34B960686';

%%%%
%%  chiffrement
%%%%
C=Hight_enc(MSG, Key)
%%%%
%%  Dechiffrement
%%%%
%M=Hight_dec(C, Key)