#include <fstream>
#include <string>
#include "Aircraft.h"

Aircraft::Aircraft(unsigned int SeatCount)
{
	this->Manifest = new Passenger[SeatCount]; //creating passngers no seat
	this->NumOfPassengers = 0;
	this->NumOfSeats = SeatCount;
}

Aircraft::Aircraft(Aircraft& src)
{
	*this = src; //calling cpy constrcotr

}

Aircraft& Aircraft::operator=(Aircraft& src)
{
	//checking self assignment
	if (this != &src)
	{
		//shallow vars
		this->NumOfPassengers = src.NumOfPassengers;
		this->NumOfSeats = src.NumOfSeats;
		//deep cpy

		for (int i = 0; i < this->NumOfSeats; i++)
		{
			this->Manifest[i] = std::move(src.Manifest[i]);
		}
	}
	else
	{
		throw "Self assignment not allowed!";
	}
	return *this;
}

Aircraft& Aircraft::operator+=(Passenger& newPassenger)
{
	//if 
	if (this->NumOfPassengers == this->NumOfSeats)
		throw "No space available, all passanger seats have been assgined";	
	int index =-1;
	for (int i = 0; i < this->NumOfSeats; i++)
	{
		//finding a 
		if (this->Manifest[i].getName() == "")
		{
			index = i;
		}
	}
	this->Manifest[index] = std::move(newPassenger);
	Manifest->AssignSeat(index);

	if (index == -1)
	{
		throw "New passanger has no seat";
	}
	for (int i = 0; i < this->NumOfSeats; i++)
	{
		if (this->Manifest[index].GetSeat() == this->Manifest[i].GetSeat() && index != i)
			throw "Seat occupied by somoneone else";
	}
}

Aircraft & Aircraft::operator-=(std::string& passangerName)
{
	Passenger temp;
	for (int i = 0; i < this->NumOfPassengers; i++)
	{
		if (this->Manifest[i].getName() == passangerName)
		{
			temp = std::move(Manifest[i]);
		}
	}
}

unsigned int Aircraft::getPassengerCount()
{
	return this->NumOfPassengers;
}

void Aircraft::display(std::ostream & os)
{
	for (int i = 0; i < this->NumOfSeats; i++)
	{
		if (Manifest[i].getName() != "" && Manifest[i].GetSeat() != -1)
			os << this->Manifest[i].getName() << ":" << this->Manifest[i].GetSeat() << std::endl;
		else
			os << "Seat " << i << " empty";
	}
}

