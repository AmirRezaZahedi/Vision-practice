import os

folder_path = "output"


def extract_second_number(filename):
    parts = filename.split("_")
    second_number = parts[-1].split(".")[0]
    return int(second_number)
count = 0
true=0

for filename in os.listdir(folder_path):
    if filename.endswith(".txt"):
        file_path = os.path.join(folder_path, filename)
        
        
        second_number_from_filename = extract_second_number(filename)
        
       
        with open(file_path, 'r') as file:
            number_in_file = int(file.read().strip())
        
        
        if number_in_file == second_number_from_filename:
            print(f"Numbers match in file {filename}")
            true = true + 1
        else:
            print(f"Numbers do not match in file {filename}."
            f"    {(number_in_file - second_number_from_filename) / second_number_from_filename:.2%} "
            "is the percentage difference of the two numbers")

            
        count = count+1
print('precision:', true * 100/count, '%')
