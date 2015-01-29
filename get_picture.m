resim = imread('./gazebo_components/height_map/map.png');
tablo = colormap;
boyut = length(resim);
resim_aug = zeros(boyut*boyut,1);

for i = 1 : 1 : boyut*boyut;
    
resim_aug(i) = resim(i);
end

X_aug = [];
Y_aug = [];
X = 1 : 1 : boyut;


for i = 1 : 1 : boyut;
    X_aug = [X_aug X];
    Y_aug = [Y_aug; ones(boyut,1)*i];
end

X_aug = X_aug';
X_aug = flip(X_aug);
S = 100 * ones(boyut*boyut,1);

scatter(Y_aug/boyut,X_aug/boyut,S,resim_aug/5);

