function sEPS(Q)

aux = dir([Q '_*.eps']);
if isempty(aux),
    print('-deps', '-r300', [Q '_01']);
elseif (aux(end).name(6) == '9'),
    print('-deps', '-r300', [Q '_'  num2str(str2double(aux(end).name(5:6)) + 1)]);
else
    print('-deps', '-r300', [Q '_'  num2str(aux(end).name(5)) num2str(str2double(aux(end).name(6)) + 1)]);
end

end