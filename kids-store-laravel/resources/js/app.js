import './bootstrap';
import swal from 'sweetalert';
var alertDiv = document.getElementById("add-product");

// Close the alert after 2 seconds
if(alertDiv!=null){
setTimeout(function() {
  alertDiv.style.display = "none";
}, 2000);
}

const deleteProduct = document.querySelectorAll('.delete-product-form');
deleteProduct.forEach((button) => {
        button.addEventListener('submit', (event) => {
            event.preventDefault();

            
            swal({
              title: "هل أنت متأكد من الحذف؟",
              text: "بمجرد الحذف لاتستطيع استرجاع العنصر",
              icon: "warning",
              buttons: ["إلغاء","نعم"],
              dangerMode: true,
            })
            .then((willDelete) => {
              if (willDelete) {

                button.submit();
              
                swal("تم حذف العنصر بنجاح", {
                  icon: "success",
                });
              } else {
                swal({
                  text:"لم يتم الحذف..",
                buttons:"حسنا"
                }
                );
              }
            });
        });
    });


    new MultiSelectTag('categories')  // id

    
var inputElement = document.querySelector('.input');

inputElement.placeholder = 'ابحث';

