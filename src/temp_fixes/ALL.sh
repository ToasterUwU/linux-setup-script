echo "Temp Fix for OpenJDK 20 not installing because of ca-certificates-java not being able to configure itself" #since it needs java, and java 20 needs certicates to install. Meaning they need each other, which cant work
sudo apt install openjdk-19-jre-headless openjdk-19-jre -y
sudo apt install ca-certificates-java -y
echo ""

echo "Fix Cura not starting because of QT_STYLE_OVERRIDE being set"
sudo flatpak override --env=QT_STYLE_OVERRIDE="" com.ultimaker.cura
echo ""