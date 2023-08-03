pragma solidity ^0.8.21;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); //объявил событие оповещения внешнему интерфейсу о создании нового зомби

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private { //Закрытая функция создания зомби с параметрами имя и ДНК
        uint id = zombies.push(Zombie(_name, _dna)) - 1; // Вернет индекс только что добавленного зомби и сохранит результат в zombie.push для события NewZombie
        NewZombie(id, _name, _dna); //Событие запускается каждый раз после добавления нового зомби в массив zombies
    }

    function _generateRandomDna(string _str) private view returns (uint) { //закрытая функция генерации рандомной ДНК через кеччак256
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public { //публичная функция создания рандом зомби (имя + рандом ДНК)
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
