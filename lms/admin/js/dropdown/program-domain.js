
$(document).ready(function() {
    // Fetch programs from database using AJAX
    $.ajax({
        url: 'http://localhost/lms/admin/api/dropdown/fetch_programs.php',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            // Populate program dropdown with options
            var programDropdown = $('#programDropdown');
            $.each(response, function(index, program) {
                programDropdown.append($('<option></option>').attr('value', program.ProgramCode).text(program.ProgramCode)); // Change here
            });
        },
        error: function(xhr, status, error) {
            console.error('Error fetching programs:', error);
        }
    });

    // Event listener for program dropdown change
    $('#programDropdown').change(function() {
        var programCode = $(this).val();
        if (programCode !== '') {
            // Fetch domains based on selected program using AJAX
            $.ajax({
                url: 'http://localhost/lms/admin/api/dropdown/fetch_domains.php',
                type: 'GET',
                dataType: 'json',
                data: { programCode: programCode },
                success: function(response) {
                    // Clear existing options
                    $('#domainDropdown').empty();
                    // Populate domain dropdown with options
                    var domainDropdown = $('#domainDropdown');
                    $.each(response, function(index, domain) {
                        domainDropdown.append($('<option></option>').attr('value', domain.DomainName).text(domain.DomainName));
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching domains:', error);
                }
            });
        } else {
            // Clear domain dropdown if no program is selected
            $('#domainDropdown').empty();
        }
    });
    // Fetch programs from database using AJAX
    $.ajax({
        url: 'http://localhost/lms/admin/api/dropdown/fetch_programs.php',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            // Populate program dropdown with options
            var programDropdown = $('#editProgram');
            $.each(response, function(index, program) {
                programDropdown.append($('<option></option>').attr('value', program.ProgramCode).text(program.ProgramCode));
            });
            
            // Set selected value for program dropdown
            $('#editProgram').val(course.Program);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching programs:', error);
        }
    });

    // Event listener for program dropdown change
    $('#editProgram').change(function() {
        var programCode = $(this).val();
        if (programCode !== '') {
            // Fetch domains based on selected program using AJAX
            $.ajax({
                url: 'http://localhost/lms/admin/api/dropdown/fetch_domains.php',
                type: 'GET',
                dataType: 'json',
                data: { programCode: programCode },
                success: function(response) {
                    // Populate domain dropdown with options
                    var domainDropdown = $('#editDomain');
                    $.each(response, function(index, domain) {
                        domainDropdown.append($('<option></option>').attr('value', domain.DomainName).text(domain.DomainName));
                    });
                    
                    // Set selected value for domain dropdown
                    $('#editDomain').val(course.Domain);
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching domains:', error);
                }
            });
        }
    });
});
